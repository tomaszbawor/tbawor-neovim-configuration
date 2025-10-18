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
      "stylua", -- Lua formatter
      "rust_analyzer",
      "kotlin_lsp",
      "prettier",
    },
  },
}
