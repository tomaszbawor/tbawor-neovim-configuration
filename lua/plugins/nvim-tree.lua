return {
        "nvim-tree/nvim-tree.lua",
        opts = { on_attach = on_attach_change },
    keys = {
      {  "<leader>e", ":NvimTreeToggle <CR>", desc = "Open file explorer" },
    }
}
