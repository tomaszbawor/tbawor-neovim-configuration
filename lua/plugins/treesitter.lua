return {
  "nvim-treesitter/nvim-treesitter",
  build = ":TSUpdate",
  config = function(_, opts)
    local ok, configs = pcall(require, "nvim-treesitter.configs")
    if ok then
      configs.setup(opts)
      return
    end

    local ts = require("nvim-treesitter")
    ts.setup({})

    if opts.ensure_installed and #opts.ensure_installed > 0 then
      local installed = ts.get_installed()
      local missing = vim.tbl_filter(function(lang)
        return not vim.list_contains(installed, lang)
      end, opts.ensure_installed)

      if #missing > 0 then
        ts.install(missing)
      end
    end

    if opts.highlight and opts.highlight.enable then
      vim.api.nvim_create_autocmd("FileType", {
        callback = function()
          pcall(vim.treesitter.start)
        end,
      })
    end

    if opts.indent and opts.indent.enable then
      vim.api.nvim_create_autocmd("FileType", {
        callback = function()
          vim.bo.indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
        end,
      })
    end
  end,
  opts = {
    ensure_installed = { "c", "lua", "vim", "javascript", "python", "typescript", "tsx", "java", "kotlin", "gleam" },
    highlight = { enable = true },
    indent = { enable = true },
  },
}
