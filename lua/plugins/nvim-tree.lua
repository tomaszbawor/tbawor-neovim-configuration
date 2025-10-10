return {
  "nvim-tree/nvim-tree.lua",
  lazy = false,
  opts = {
    on_attach = on_attach_change,
    renderer = {
      group_empty = true,
      highlight_git = true,
    },
  },
  keys = {
    { "<leader>e", ":NvimTreeToggle <CR>", desc = "Open file explorer" },
  },
}
