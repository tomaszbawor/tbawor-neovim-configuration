return {
  "nvim-tree/nvim-tree.lua",
  lazy = false,
  opts = {
    renderer = {
      group_empty = true,
      highlight_git = true,
    },
    filters = {
      dotfiles = false,
    },
  },
  keys = {
    { "<leader>e", ":NvimTreeToggle <CR>", desc = "Open file explorer" },
  },
}
