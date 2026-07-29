return {
  "lewis6991/gitsigns.nvim",
  event = { "BufReadPre", "BufNewFile" },
  opts = {
    on_attach = function(bufnr)
      local gs = package.loaded.gitsigns

      -- buffer-local map helper — closes over bufnr
      local function map(mode, l, r, desc)
        vim.keymap.set(mode, l, r, { buffer = bufnr, desc = desc })
      end

      -- =====================================================================
      -- USER: gitsigns keymaps. Three groups: navigation, actions, text object.
      -- ---------------------------------------------------------------------
      -- IMPORTANT: gitsigns deprecated `next_hunk`/`prev_hunk` in favor of
      -- `nav_hunk("next"/"prev")`. Also `undo_stage_hunk` was removed —
      -- `stage_hunk` itself is now a toggle.
      --
      -- NAVIGATION (normal mode, function wrapper):
      --   ]h  ->  function() gs.nav_hunk("next") end   desc: "Next Hunk"
      --   [h  ->  function() gs.nav_hunk("prev") end   desc: "Prev Hunk"
      --
      -- ACTIONS (mostly normal mode unless noted):
      --   <leader>hs (n) ->  gs.stage_hunk                               desc: "Stage hunk"
      --   <leader>hr (n) ->  gs.reset_hunk                               desc: "Reset hunk"
      --   <leader>hs (v) ->  function() gs.stage_hunk({ vim.fn.line("."), vim.fn.line("v") }) end   desc: "Stage hunk"
      --   <leader>hr (v) ->  function() gs.reset_hunk({ vim.fn.line("."), vim.fn.line("v") }) end   desc: "Reset hunk"
      --   <leader>hS (n) ->  gs.stage_buffer                             desc: "Stage buffer"
      --   <leader>hR (n) ->  gs.reset_buffer                             desc: "Reset buffer"
      --   <leader>hp (n) ->  gs.preview_hunk                             desc: "Preview hunk"
      --   <leader>hb (n) ->  function() gs.blame_line({ full = true }) end   desc: "Blame line"
      --   <leader>hB (n) ->  gs.toggle_current_line_blame                desc: "Toggle line blame"
      --   <leader>hd (n) ->  gs.diffthis                                 desc: "Diff this"
      --   <leader>hD (n) ->  function() gs.diffthis("~") end             desc: "Diff this ~"
      --
      -- TEXT OBJECT (operator + visual modes):
      --   ih (modes {"o", "x"}) ->  ":<C-U>Gitsigns select_hunk<CR>"    desc: "Gitsigns select hunk"
      -- =====================================================================
      
      -- navigation
      map("n", "]h", function() gs.nav_hunk("next") end, "Next Hunk")
      map("n", "[h", function() gs.nav_hunk("prev") end, "Prev Hunk")

      -- actions
      map("n", "<leader>hs", gs.stage_hunk, "Stage hunk")
      map("n", "<leader>hr", gs.reset_hunk, "Reset hunk")
      map("v", "<leader>hs", function() gs.stage_hunk({ vim.fn.line("."), vim.fn.line("v") }) end, "Stage hunk")
      map("v", "<leader>hr", function() gs.reset_hunk({ vim.fn.line("."), vim.fn.line("v") }) end, "Reset hunk")
      map("n", "<leader>hS", gs.stage_buffer, "Stage buffer")
      map("n", "<leader>hR", gs.reset_buffer, "Reset buffer")
      map("n", "<leader>hp", gs.preview_hunk, "Preview hunk")
      map("n", "<leader>hb", function() gs.blame_line({ full = true }) end, "Blame line")
      map("n", "<leader>hB", gs.toggle_current_line_blame, "Toggle line blame")
      map("n", "<leader>hd", gs.diffthis, "Diff this")
      map("n", "<leader>hD", function() gs.diffthis("~") end, "Diff this ~")

      -- text object
      map({ "o", "x" }, "ih", ":<C-U>Gitsigns select_hunk<CR>", "Gitsigns select hunk")
      
    end,
  },
}
