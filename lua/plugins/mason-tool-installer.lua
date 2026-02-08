return {
  "WhoIsSethDaniel/mason-tool-installer.nvim",
  dependencies = {
    "mason-org/mason.nvim",
  },
  opts = {
    ensure_installed = {
      "biome",
      "prettier",
      "stylua",
      "ktlint",
    },
    auto_update = true,
  },
}
