return {
  "j-hui/fidget.nvim",
  event = "LspAttach",
  opts = {
    progress = {
      display = {
        render_limit = 16,
        done_ttl = 3,
        done_icon = "✓",
        done_style = "Constant",
        progress_icon = { pattern = "dots", period = 1 },
        group_style = "Title",
        icon_style = "Question",
      },
    },
    notification = {
      window = {
        winblend = 0,
        border = "rounded",
      },
    },
  },
}
