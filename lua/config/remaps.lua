local wk = require("which-key")

local non_lsp_mappings = {
  { "<C-d>", "<C-d>zz", desc = "Half page down and center" },
  { "<C-u>", "<C-u>zz", desc = "Half page up and center" },

  { "<leader>p", '"_dP', desc = "Paste without overwrite" },
  {
    "<leader>s",
    ":%s/\\<<C-r><C-w>\\>/<C-r><C-w>/gI<Left><Left><Left>",
    desc = "Search and replace word under cursor",
  },
  { "Q", "<nop>", desc = "Disable Ex mode" },

  -- General
  { "<leader>qq", "<cmd>qa<cr>", desc = "Quit all", mode = "n" },

  -- Window Management
  { "<C-h>", "<C-w>h", desc = "Move to the left window" },
  { "<C-l>", "<C-w>l", desc = "Move to the right window" },
  { "<C-j>", "<C-w>j", desc = "Move to the down window" },
  { "<C-k>", "<C-w>k", desc = "Move to the top window" },

  -- Helpers
  { "<leader>xf", "<cmd>source %<cr>", desc = "Source current file" },
  {
    "<leader>fp",
    function()
      vim.cmd('noau normal! "vy') -- Get selection to the vim v register
      local selectedText = vim.fn.getreg("v")
      require("telescope.builtin").live_grep({ default_text = selectedText })
    end,
    mode = "v",
    desc = "Grep selected text in the project",
  },
}

wk.add(non_lsp_mappings)
