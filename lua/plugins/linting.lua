return {
  "mfussenegger/nvim-lint",
  event = { "BufReadPre", "BufNewFile" },
  config = function()
    local lint = require("lint")

    -- =====================================================================
    -- USER: linters_by_ft mapping. Each filetype maps to a list of linters.
    -- ---------------------------------------------------------------------
    -- Required (post-Python/Svelte removal):
    --
    --   javascript      = { "eslint_d" },
    --   typescript      = { "eslint_d" },
    --   javascriptreact = { "eslint_d" },
    --   typescriptreact = { "eslint_d" },
    -- =====================================================================
    lint.linters_by_ft = {
      -- web
      javascript = { "eslint_d" },
      typescript = { "eslint_d" },
      javascriptreact = { "eslint_d" },
      typescriptreact = { "eslint_d" },
      -- system programming
      go = { "golangcilint" }, -- meta-linter; runs vet/staticcheck/etc.
    }

    -- run linters automatically on these events
    local lint_augroup = vim.api.nvim_create_augroup("lint", { clear = true })
    vim.api.nvim_create_autocmd({ "BufEnter", "BufWritePost", "InsertLeave" }, {
      group = lint_augroup,
      callback = function()
        lint.try_lint()
      end,
    })

    -- manual trigger
    vim.keymap.set("n", "<leader>l", function()
      lint.try_lint()
    end, { desc = "Trigger linting for current file" })
  end,
}
