return {
  {
    "neovim/nvim-lspconfig",
    opts = {
      servers = {
        nil_ls = {
          mason = false,
          cmd = { "nil" },
        },
      },
    },
  },
}
