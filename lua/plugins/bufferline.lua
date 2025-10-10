return {
  "akinsho/bufferline.nvim",
  version = "*",
  dependencies = "nvim-tree/nvim-web-devicons",
  keys = {
    { "<S-l>", ":BufferLineCycleNext<CR>", desc = "Next buffer" },
    { "<S-h>", ":BufferLineCyclePrev<CR>", desc = "Previous buffer" },
  },
  lazy = false,
  opts = {
    options = {
      offsets = {
        {
          filetype = "NvimTree",
          text = "Nvim Tree",
          separator = true,
          text_align = "left",
        },
      },
      diagnostics = "nvim_lsp",
      separator_style = { "", "" },
      modified_icon = "●",
      show_close_icon = false,
      show_buffer_close_icons = false,
    },
  },
}
