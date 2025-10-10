return {
	'nvim-telescope/telescope.nvim', tag = '0.1.8',
	dependencies = {'nvim-lua/plenary.nvim'},
  opts = {},
  keys = { 
    { "<leader>ff", function() require("telescope.builtin").find_files() end, desc = "Find files" },
    { "<leader>fg", function() require("telescope.builtin").live_grep() end,  desc = "Live grep" },
    { "<leader>fb", function() require("telescope.builtin").buffers() end,    desc = "Buffers" },
    { "<leader>fr", function() require("telescope.builtin").oldfiles() end,   desc = "Recent files" },
    { "<leader>fh", function() require("telescope.builtin").help_tags() end,  desc = "Help" },
  }

}
