return {
  "ibhagwan/fzf-lua",
  -- Preload shortly after startup (in the background) instead of on the
  -- first <leader><leader> press. This removes the "freeze on first use".
  event = "VeryLazy",
  opts = function(_, opts)
    -- Faster file walk: use fd, skip heavy/irrelevant dirs.
    opts.files = vim.tbl_deep_extend("force", opts.files or {}, {
      fd_opts = table.concat({
        "--color=never",
        "--type f",
        "--hidden",
        "--follow",
        "--exclude .git",
        "--exclude node_modules",
        "--exclude .cache",
        "--exclude target", -- rust
        "--exclude dist",
        "--exclude build",
      }, " "),
    })
    return opts
  end,
}
