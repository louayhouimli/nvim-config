return {
  "gbprod/substitute.nvim",
  event = { "BufReadPre", "BufNewFile" },
  config = function()
    local substitute = require("substitute")
    substitute.setup()

    local map = vim.keymap.set

    -- =====================================================================
    -- USER: substitute keymaps. Same pattern as Phase 1 keymaps.
    -- ---------------------------------------------------------------------
    --   "s"  (n) -> substitute.operator   desc: "Substitute with motion"
    --   "ss" (n) -> substitute.line       desc: "Substitute line"
    --   "S"  (n) -> substitute.eol        desc: "Substitute to end of line"
    --   "s"  (x) -> substitute.visual     desc: "Substitute in visual mode"
    --
    -- Note: rhs is a Lua function reference (no quotes), e.g. substitute.operator
    -- Mode "x" is visual mode (block + characterwise + linewise visual).
    -- =====================================================================
    
    
    map("n", "s", substitute.operator, { desc = "Substitute with motion" })
    map("n", "ss", substitute.line, { desc = "Substitute line" })
    map("n", "S", substitute.eol, { desc = "Substitute to end of line" })
    map("x", "s", substitute.visual, { desc = "Substitute in visual mode" })

  end,
}
