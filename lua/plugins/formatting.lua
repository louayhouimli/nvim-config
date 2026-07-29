return {
  "stevearc/conform.nvim",
  event = { "BufReadPre", "BufNewFile" },
  config = function()
    local conform = require("conform")

    conform.setup({
      -- =====================================================================
      -- USER: formatters_by_ft mapping. Each filetype maps to a list of
      -- formatters; conform runs them in order on each save.
      -- ---------------------------------------------------------------------
      -- Required (post-Python-removal):
      --
      --   javascript      = { "prettier" },
      --   typescript      = { "prettier" },
      --   javascriptreact = { "prettier" },
      --   typescriptreact = { "prettier" },
      --   css             = { "prettier" },
      --   html            = { "prettier" },
      --   json            = { "prettier" },
      --   yaml            = { "prettier" },
      --   markdown        = { "prettier" },
      --   lua             = { "stylua" },
      -- =====================================================================
      formatters_by_ft = {
        -- web
        javascript = { "prettier" },
        typescript = { "prettier" },
        javascriptreact = { "prettier" },
        typescriptreact = { "prettier" },
        css = { "prettier" },
        html = { "prettier" },
        json = { "prettier" },
        yaml = { "prettier" },
        markdown = { "prettier" },
        -- editor config
        lua = { "stylua" },
        -- system programming
        c = { "clang-format" },
        cpp = { "clang-format" },
        go = { "goimports", "gofumpt" }, -- imports first, then format
      },

      format_on_save = {
        lsp_fallback = true, -- if no formatter for ft, fall back to LSP formatting
        async = false, -- block save until format completes (no race with :wq)
        timeout_ms = 1000, -- cap at 1 second to avoid hangs
      },
    })

    -- manual format command (range or whole file)
    vim.keymap.set({ "n", "v" }, "<leader>mp", function()
      conform.format({
        lsp_fallback = true,
        async = false,
        timeout_ms = 1000,
      })
    end, { desc = "Format file or range (in visual mode)" })
  end,
}
