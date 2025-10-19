return {
  "mason-org/mason-lspconfig.nvim",
  dependencies = {
    "mason-org/mason.nvim",
    "neovim/nvim-lspconfig",
  },
  lazy = false,
  opts = {
    ensure_installed = {
      "lua_ls", -- Lua Language Server
      "ts_ls", -- Typescript
      "nil", -- Nix language server
      "rust_analyzer",
      "kotlin_lsp",
      "basedpyright",
    },
  },
}
