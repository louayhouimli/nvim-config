return {
  "rmagatti/auto-session",
  config = function()
    require("auto-session").setup({
      auto_restore_enabled = false, -- explicit restore via <leader>wr only
      suppressed_dirs = {
        "~/",
        "~/development/",
        "~/Downloads",
        "~/Desktop/",
        "~/Documents",
        "~/Tools",
      },
    })

    local map = vim.keymap.set
    map("n", "<leader>wr", "<cmd>SessionRestore<CR>", { desc = "Restore session for cwd" })
    map("n", "<leader>ws", "<cmd>SessionSave<CR>", { desc = "Save session for cwd" })
  end,
}
