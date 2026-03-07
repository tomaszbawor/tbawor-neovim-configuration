return {
  "mason-org/mason-lspconfig.nvim",
  dependencies = {
    "mason-org/mason.nvim",
    "neovim/nvim-lspconfig",
  },
  lazy = false,
  config = function()
    require("config.lsp").setup()
    require("mason-lspconfig").setup({
      ensure_installed = {
        "clangd",
        "lua_ls",
        "rust_analyzer",
        "basedpyright",
        "ts_ls",
        "kotlin_language_server",
      },
    })
  end,
}
