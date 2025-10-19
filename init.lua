-- Global helper function for printing
P = function(args)
  print(vim.inspect(args))
end

vim.g.mapleader = " " -- Set leader key to space before loading plugins

-- disable netrw (neovim default file explorer)
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

require("config.lazy")
require("config.settings")
require("config.remaps")
require("config.lsp")

-- Replace UI Select with telescope
require("telescope").load_extension("ui-select")
