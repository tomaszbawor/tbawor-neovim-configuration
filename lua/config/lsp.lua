-- Configuration  for the LSPs
vim.o.signcolumn = "yes"

vim.diagnostic.config({
  virtual_text = true, -- Inline Diagnostic Texts
})

-- clangd (C/C++)
-- Neovim 0.11+ prefers the built-in API (vim.lsp.config) over require('lspconfig').
-- On Nix/NixOS there is often no /usr/include, so clangd must be allowed to query
-- the actual compiler from compile_commands.json for system include paths.
local function clangd_cmd()
  local exe = vim.fn.exepath("clangd")
  if exe ~= nil and exe ~= "" then
    return exe
  end

  local mason = vim.fn.stdpath("data") .. "/mason/bin/clangd"
  if vim.uv.fs_stat(mason) then
    return mason
  end

  return "clangd"
end

local function clangd_root_dir(bufnr)
  local fname = vim.api.nvim_buf_get_name(bufnr)
  if fname == nil or fname == "" then
    return vim.uv.cwd()
  end

  local dir = vim.fs.dirname(fname)
  local markers = { ".clangd", "compile_commands.json", "compile_flags.txt", ".git" }
  local found = vim.fs.find(markers, { path = dir, upward = true })

  if found ~= nil and found[1] ~= nil then
    return vim.fs.dirname(found[1])
  end

  return dir
end

vim.lsp.config("clangd", {
  cmd = {
    clangd_cmd(),
    "--background-index",
    "--clang-tidy",
    "--header-insertion=iwyu",
    "--completion-style=detailed",
    "--query-driver=/nix/store/*/bin/gcc,/nix/store/*/bin/*-gcc,/nix/store/*/bin/cc,/nix/store/*/bin/clang,/nix/store/*/bin/clang++",
  },
  filetypes = { "c", "cpp", "objc", "objcpp", "cuda", "proto" },
  root_dir = clangd_root_dir,
})

vim.lsp.enable("clangd")
