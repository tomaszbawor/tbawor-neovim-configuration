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
      "rust_analyzer",
      "kotlin_lsp",
    },
  },
}
