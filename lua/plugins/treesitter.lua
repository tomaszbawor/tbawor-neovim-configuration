return {
  "nvim-treesitter/nvim-treesitter",
  build = ":TSUpdate",
  config = function(_, opts)
    require("nvim-treesitter.configs").setup(opts)
  end,
  opts = {
    ensure_installed = { "c", "lua", "vim", "javascript", "python", "typescript", "java", "kotlin" },
    highlight = { enable = true },
    indent = { enable = true },
  },
}
