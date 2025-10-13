return {
  "akinsho/toggleterm.nvim",
  version = "*",
  opts = {},
  lazy = false,
  keys = {
    { "<leader>ft", "<Cmd>ToggleTerm direction=float<CR>", desc = "Toggle floating terminal" },
    { "<leader>tt", "<Cmd>ToggleTerm<CR>", desc = "Toggle regular terminal" },
    { "<leader>tt", "<Cmd>ToggleTerm<CR>", desc = "Toggle regular terminal", mode = "t" },
    -- <C-_> Means Control + / in neovim. I do not know why.
    { "<C-_>", "<Cmd>ToggleTerm<CR>", desc = "Toggle terminal" },
    { "<C-_>", "<Cmd>ToggleTerm<CR>", mode = "t", desc = "Toggle terminal" },
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
