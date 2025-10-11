return {
  "akinsho/toggleterm.nvim",
  version = "*",
  opts = {},
  lazy = false,
  keys = {
    { "<leader>ft", "<Cmd>ToggleTerm direction=float<CR>", desc = "Toggle floating terminal" },
    { "<leader>tt", "<Cmd>ToggleTerm<CR>", desc = "Toggle terminal" },
    {
      "<C-w>",
      function()
        vim.api.nvim_input("<C-\\><C-n><cmd>ToggleTerm<cr>")
      end,
      mode = "t",
      desc = "Toggling terminal off",
    },
  },
}
