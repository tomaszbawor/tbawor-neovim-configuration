return {
  "stevearc/conform.nvim",
  config = function()
    require("conform").setup({
      formatters_by_ft = {
        lua = { "stylua" },
        markdown = { "prettier" },
        kotlin = { "ktlint" },
        javascript = { "biome", "prettier", stop_after_first = true },
        javascriptreact = { "biome", "prettier", stop_after_first = true },
        typescript = { "biome", "prettier", stop_after_first = true },
        typescriptreact = { "biome", "prettier", stop_after_first = true },
        json = { "biome", "prettier", stop_after_first = true },
        jsonc = { "biome", "prettier", stop_after_first = true },
      },
      formatters = {
        biome = {
          require_cwd = true,
          cwd = require("conform.util").root_file({
            "biome.json",
            "biome.jsonc",
          }),
        },
      },
      format_on_save = {
        timeout_ms = 1000,
        lsp_format = "fallback",
      },
    })
  end,
}
