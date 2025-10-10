local wk = require("which-key")

local non_lsp_mappings = {
  { "<C-d>", "<C-d>zz", desc = "Half page down and center" },
  { "<C-u>", "<C-u>zz", desc = "Half page up and center" },
  { "<leader>/", "<Plug>(comment_toggle_linewise_current)", desc = "Toggle comment" },
  { "<leader>p", '"_dP', desc = "Paste without overwrite" },
  {
    "<leader>s",
    ":%s/\\<<C-r><C-w>\\>/<C-r><C-w>/gI<Left><Left><Left>",
    desc = "Search and replace word under cursor",
  },
  { "Q", "<nop>", desc = "Disable Ex mode" },

  -- Window Management
  { "<C-h>", "<C-w>h", desc = "Move to the left window" },
  { "<C-l>", "<C-w>l", desc = "Move to the right window" },
  { "<C-j>", "<C-w>j", desc = "Move to the down window" },
  { "<C-k>", "<C-w>k", desc = "Move to the top window" },
}

wk.add(non_lsp_mappings)
