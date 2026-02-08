local M = {}

function M.setup()
  -- LSP configuration (Neovim 0.11+ native API).
  -- mason-lspconfig (v2+) will call vim.lsp.enable() for installed servers.

  vim.o.signcolumn = "yes"
  vim.diagnostic.config({
    virtual_text = true,
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
  })

  -- Buffer-local LSP keymaps.
  vim.api.nvim_create_autocmd("LspAttach", {
    group = vim.api.nvim_create_augroup("omo_lsp_keymaps", { clear = true }),
    callback = function(args)
      local opts = { buffer = args.buf }
      vim.keymap.set("n", "K", vim.lsp.buf.hover, vim.tbl_extend("force", opts, { desc = "Hover" }))
      vim.keymap.set("n", "gK", vim.lsp.buf.signature_help, vim.tbl_extend("force", opts, { desc = "Signature help" }))
    end,
  })

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
