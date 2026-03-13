local M = {}

-- Diagnostic signs with icons
local diagnostic_signs = {
  [vim.diagnostic.severity.ERROR] = " ",
  [vim.diagnostic.severity.WARN] = " ",
  [vim.diagnostic.severity.HINT] = "󰌵 ",
  [vim.diagnostic.severity.INFO] = " ",
}

function M.setup()
  -- LSP configuration (Neovim 0.11+ native API).
  -- mason-lspconfig (v2+) will call vim.lsp.enable() for installed servers.

  vim.o.signcolumn = "yes"

  -- Enhanced diagnostic configuration
  vim.diagnostic.config({
    virtual_text = {
      prefix = "●",
      spacing = 4,
      source = "if_many",
    },
    float = {
      focusable = true,
      style = "minimal",
      border = "rounded",
      source = true,
      header = "",
      prefix = "",
    },
    signs = {
      text = diagnostic_signs,
    },
    underline = true,
    update_in_insert = false,
    severity_sort = true,
  })

  -- Ensure Mason-installed binaries are discoverable.
  vim.env.PATH = vim.fn.stdpath("data") .. "/mason/bin:" .. (vim.env.PATH or "")

  local capabilities = vim.lsp.protocol.make_client_capabilities()
  do
    local ok, blink = pcall(require, "blink.cmp")
    if ok and type(blink.get_lsp_capabilities) == "function" then
      capabilities = blink.get_lsp_capabilities(capabilities)
    end
  end

  -- Apply capabilities to all LSP configs.
  vim.lsp.config("*", {
    capabilities = capabilities,
    offset_encoding = "utf-16",
  })

  -- Buffer-local LSP keymaps.
  vim.api.nvim_create_autocmd("LspAttach", {
    group = vim.api.nvim_create_augroup("omo_lsp_keymaps", { clear = true }),
    callback = function(args)
      local bufnr = args.buf
      local client = vim.lsp.get_client_by_id(args.data.client_id)

      local function map(mode, lhs, rhs, desc)
        vim.keymap.set(mode, lhs, rhs, { buffer = bufnr, desc = desc })
      end

      local function lsp_telescope(method, opts, fallback)
        local ok, builtin = pcall(require, "telescope.builtin")
        if ok and type(builtin[method]) == "function" then
          return builtin[method](opts or {})
        end
        if fallback then
          return fallback()
        end
      end

      -- Navigation (using telescope for fancy UI)
      map("n", "gd", function()
        lsp_telescope("lsp_definitions", { reuse_win = true }, vim.lsp.buf.definition)
      end, "Go to definition")

      map("n", "gD", vim.lsp.buf.declaration, "Go to declaration")

      map("n", "gr", function()
        lsp_telescope("lsp_references", { include_declaration = false }, vim.lsp.buf.references)
      end, "References")

      map("n", "gi", function()
        lsp_telescope("lsp_implementations", { reuse_win = true }, vim.lsp.buf.implementation)
      end, "Implementations")

      map("n", "gy", function()
        lsp_telescope("lsp_type_definitions", { reuse_win = true }, vim.lsp.buf.type_definition)
      end, "Type definition")

      -- Hover and signature
      map("n", "K", vim.lsp.buf.hover, "Hover")
      map("n", "gK", vim.lsp.buf.signature_help, "Signature help")
      map("i", "<C-k>", vim.lsp.buf.signature_help, "Signature help")

      -- Code actions and refactoring
      map({ "n", "v" }, "<leader>ca", vim.lsp.buf.code_action, "Code actions")
      map("n", "<leader>rn", vim.lsp.buf.rename, "Rename symbol")

      -- Diagnostics
      map("n", "[d", function()
        vim.diagnostic.jump({ count = -1, float = true })
      end, "Previous diagnostic")

      map("n", "]d", function()
        vim.diagnostic.jump({ count = 1, float = true })
      end, "Next diagnostic")

      map("n", "[e", function()
        vim.diagnostic.jump({ count = -1, severity = vim.diagnostic.severity.ERROR, float = true })
      end, "Previous error")

      map("n", "]e", function()
        vim.diagnostic.jump({ count = 1, severity = vim.diagnostic.severity.ERROR, float = true })
      end, "Next error")

      map("n", "gl", vim.diagnostic.open_float, "Show diagnostics")

      -- Document highlight (highlight references under cursor)
      if client and client.supports_method("textDocument/documentHighlight") then
        local highlight_group = vim.api.nvim_create_augroup("lsp_document_highlight_" .. bufnr, { clear = true })
        vim.api.nvim_create_autocmd({ "CursorHold", "CursorHoldI" }, {
          group = highlight_group,
          buffer = bufnr,
          callback = vim.lsp.buf.document_highlight,
        })
        vim.api.nvim_create_autocmd({ "CursorMoved", "CursorMovedI" }, {
          group = highlight_group,
          buffer = bufnr,
          callback = vim.lsp.buf.clear_references,
        })
      end

      -- Inlay hints toggle (if supported)
      if client and client.supports_method("textDocument/inlayHint") then
        map("n", "<leader>uh", function()
          vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled({ bufnr = bufnr }), { bufnr = bufnr })
        end, "Toggle inlay hints")
      end
    end,
  })

  -- Gleam (ships its own LSP via `gleam lsp`; installed via Nix, not Mason)
  vim.lsp.config("gleam", {
    cmd = { "gleam", "lsp" },
    filetypes = { "gleam" },
    root_markers = { "gleam.toml", ".git" },
  })
  vim.lsp.enable("gleam")

  vim.lsp.config("clangd", {
    cmd = {
      "clangd",
      "--background-index",
      "--clang-tidy",
      "--header-insertion=iwyu",
      "--completion-style=detailed",
      "--query-driver=/nix/store/*/bin/gcc,/nix/store/*/bin/*-gcc,/nix/store/*/bin/cc,/nix/store/*/bin/clang,/nix/store/*/bin/clang++",
    },
    filetypes = { "c", "cpp", "objc", "objcpp", "cuda", "proto" },
    root_dir = function(bufnr, on_dir)
      local root = vim.fs.root(bufnr, { ".clangd", "compile_commands.json", "compile_flags.txt", ".git" })
      if not root or root == "" then
        local fname = vim.api.nvim_buf_get_name(bufnr)
        root = (fname ~= nil and fname ~= "") and vim.fs.dirname(fname) or vim.uv.cwd()
      end
      on_dir(root)
    end,
  })
end

return M
