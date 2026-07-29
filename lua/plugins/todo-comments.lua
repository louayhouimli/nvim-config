return {
  "folke/todo-comments.nvim",
  event = { "BufReadPre", "BufNewFile" },
  dependencies = { "nvim-lua/plenary.nvim" },
  config = function()
    local todo = require("todo-comments")
    todo.setup()

    local map = vim.keymap.set

    -- =====================================================================
    -- USER: jump keymaps. Two mappings, both normal mode.
    -- ---------------------------------------------------------------------
    --   "]t"  ->  function() todo.jump_next() end   desc: "Next todo comment"
    --   "[t"  ->  function() todo.jump_prev() end   desc: "Previous todo comment"
    --
    -- Why wrap in function() ... end?
    -- todo.jump_next can take optional args (e.g. {keywords = {"FIX", "BUG"}}).
    -- Wrapping ensures vim.keymap.set passes no args, calling the default.
    -- =====================================================================

    map("n", "]t", function() todo.jump_next() end, { desc = "Next todo comment" })
    map("n", "[t", function() todo.jump_prev() end, { desc = "Previous todo comment" })
  end,
}
