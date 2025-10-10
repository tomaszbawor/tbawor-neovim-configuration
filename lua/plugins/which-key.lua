return {
  "folke/which-key.nvim",
  event = "VeryLazy",
  opts = {
    delay = 500, -- Delay before popup
  },
  keys = {
    {
      "<leader>?",
      function()
        require("which-key").show({ global = false })
      end,
      desc = "Buffer Local Keymaps (which-key)",
    },
  },
}
