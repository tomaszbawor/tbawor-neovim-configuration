return {
  "mason-org/mason.nvim",
  lazy = true,
  cmd = "Mason",
  opts = {
    ui = {
      icons = {
        package_installed = "✓",
        package_pending = "➜",
        package_uninstalled = "✗",
      },
    },
  },
  keys = {
    {
      "<leader>cm",
      ":Mason <CR>",
      desc = "Show mason gui",
    },
  },
}
