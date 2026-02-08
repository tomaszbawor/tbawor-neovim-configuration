return {
  "nvim-telescope/telescope-ui-select.nvim",
  dependencies = {
    "nvim-telescope/telescope.nvim",
  },
  opts = {},
  config = function()
    require("telescope").load_extension("ui-select")
  end,
  lazy = true,
}
