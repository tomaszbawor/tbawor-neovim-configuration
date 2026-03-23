return {
	-- add gruvbox
	{
		"ankushbhagats/pastel.nvim",
		lazy = false,
		priority = 1000,
		config = function()
			require("pastel").setup()
		end,
	},

	-- Configure LazyVim to load gruvbox
	{
		"LazyVim/LazyVim",
		opts = {
			colorscheme = "pasteldark",
		},
	},
}
