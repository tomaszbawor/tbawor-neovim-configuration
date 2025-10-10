vim.g.mapleader = " " -- Set leader key to space before loading plugins

-- disable netrw (neovim default file explorer)
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

require("config.lazy")
require("config.settings")
require("config.remaps")
