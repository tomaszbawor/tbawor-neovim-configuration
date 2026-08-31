return {
  {
    "gipo355/nvim-intellij-lsp",
    opts = {
      kotlin = true,
    },
  },
  {
    "neovim/nvim-lspconfig",
    opts = {
      servers = {
        jdtls = { enabled = false },
        kotlin_language_server = { enabled = false },
      },
    },
  },
  {
    "mfussenegger/nvim-jdtls",
    enabled = false,
  },
}
