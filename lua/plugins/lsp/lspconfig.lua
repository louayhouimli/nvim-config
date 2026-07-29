return {
  "neovim/nvim-lspconfig",
  event = { "BufReadPre", "BufNewFile" },
  dependencies = {
    "hrsh7th/cmp-nvim-lsp",
    { "antosha417/nvim-lsp-file-operations", config = true },
    { "folke/neodev.nvim", opts = {} },
  },
  config = function()
    local cmp_nvim_lsp = require("cmp_nvim_lsp")

    -- =========================================================================
    -- LspAttach autocmd: buffer-local keymaps when an LSP attaches to a buffer.
    -- This pattern (vs setting on_attach per-server) means new servers added
    -- later automatically get these keymaps — no per-server wiring needed.
    -- =========================================================================
    vim.api.nvim_create_autocmd("LspAttach", {
      group = vim.api.nvim_create_augroup("UserLspConfig", {}),
      callback = function(ev)
        local opts = { buffer = ev.buf, silent = true }
        local map = vim.keymap.set

        -- =====================================================================
        -- USER: LSP keymaps. 12 mappings.
        -- ---------------------------------------------------------------------
        -- Each call uses the helper pattern:
        --   map(<mode>, <lhs>, <rhs>, vim.tbl_extend("force", opts, { desc = "..." }))
        -- The vim.tbl_extend call merges {buffer=ev.buf, silent=true} (from `opts`
        -- above) with {desc = "..."} so each keymap is buffer-local AND has a
        -- description for which-key.
        --
        -- Required mappings (same as old config):
        --
        --   gR          "<cmd>Telescope lsp_references<CR>"          desc: "Show LSP references"
        --   gD          vim.lsp.buf.declaration                      desc: "Go to declaration"
        --   gd          "<cmd>Telescope lsp_definitions<CR>"         desc: "Show LSP definitions"
        --   gi          "<cmd>Telescope lsp_implementations<CR>"     desc: "Show LSP implementations"
        --   gt          "<cmd>Telescope lsp_type_definitions<CR>"    desc: "Show LSP type definitions"
        --   <leader>ca  vim.lsp.buf.code_action            (modes: {"n", "v"})   desc: "See available code actions"
        --   <leader>rn  vim.lsp.buf.rename                                       desc: "Smart rename"
        --   <leader>D   "<cmd>Telescope diagnostics bufnr=0<CR>"                 desc: "Show buffer diagnostics"
        --   <leader>d   vim.diagnostic.open_float                                 desc: "Show line diagnostics"
        --   [d          function() vim.diagnostic.jump({ count = -1, float = true }) end   desc: "Go to previous diagnostic"
        --   ]d          function() vim.diagnostic.jump({ count = 1, float = true }) end    desc: "Go to next diagnostic"
        --   <leader>rs  ":LspRestart<CR>"                                         desc: "Restart LSP"
        --
        -- Note: K (hover) is built-in in Neovim 0.11+, do NOT remap.
        -- =====================================================================
        map("n", "gR", "<cmd>Telescope lsp_references<CR>", vim.tbl_extend("force", opts, { desc = "Show LSP references" }))
        map("n", "gD", vim.lsp.buf.declaration, vim.tbl_extend("force", opts, { desc = "Go to declaration" }))
        map("n", "gd", "<cmd>Telescope lsp_definitions<CR>", vim.tbl_extend("force", opts, { desc = "Show LSP definitions" }))
        map("n", "gi", "<cmd>Telescope lsp_implementations<CR>", vim.tbl_extend("force", opts, { desc = "Show LSP implementations" }))
        map("n", "gt", "<cmd>Telescope lsp_type_definitions<CR>", vim.tbl_extend("force", opts, { desc = "Show LSP type definitions" }))
        map({ "n", "v" }, "<leader>ca", vim.lsp.buf.code_action, vim.tbl_extend("force", opts, { desc = "See available code actions" }))
        map("n", "<leader>rn", vim.lsp.buf.rename, vim.tbl_extend("force", opts, { desc = "Smart rename" }))
        map("n", "<leader>D", "<cmd>Telescope diagnostics bufnr=0<CR>", vim.tbl_extend("force", opts, { desc = "Show buffer diagnostics" }))
        map("n", "<leader>d", vim.diagnostic.open_float, vim.tbl_extend("force", opts, { desc = "Show line diagnostics" }))
        map("n", "[d", function() vim.diagnostic.jump({ count = -1, float = true }) end, vim.tbl_extend("force", opts, { desc = "Go to previous diagnostic" }))
        map("n", "]d", function() vim.diagnostic.jump({ count = 1, float = true }) end, vim.tbl_extend("force", opts, { desc = "Go to next diagnostic" }))
        map("n", "<leader>rs", function()
          local bufnr = vim.api.nvim_get_current_buf()
          for _, client in ipairs(vim.lsp.get_clients({ bufnr = bufnr })) do
            vim.lsp.stop_client(client.id, false)
          end
          -- re-trigger BufReadPre so attached LSPs reattach
          vim.defer_fn(function()
            vim.cmd("edit")
          end, 100)
        end, vim.tbl_extend("force", opts, { desc = "Restart LSP" }))

      end,
    })

    -- capabilities = "what features the LSP client (us) supports"
    local capabilities = cmp_nvim_lsp.default_capabilities()

    -- diagnostic display: Nerd Font sign icons + inline virtual text
    vim.diagnostic.config({
      signs = {
        text = {
          [vim.diagnostic.severity.ERROR] = " ",
          [vim.diagnostic.severity.WARN] = " ",
          [vim.diagnostic.severity.HINT] = "󰠠 ",
          [vim.diagnostic.severity.INFO] = " ",
        },
      },
      virtual_text = {
        prefix = "●", -- bullet before each inline message
        spacing = 2, -- spaces between code and message
        source = "if_many", -- show source name only if multiple LSPs report on same line
      },
      underline = true,
      severity_sort = true, -- show errors first, warnings second, etc.
      float = {
        border = "rounded",
        source = "always",
      },
    })

    -- apply capabilities to all LSPs (the `*` glob)
    vim.lsp.config("*", {
      capabilities = capabilities,
    })

    -- emmet_ls: extend filetypes so emmet works in JSX/TSX/sass/svelte
    vim.lsp.config("emmet_ls", {
      filetypes = { "html", "typescriptreact", "javascriptreact", "css", "sass", "scss", "less" },
    })

    -- =========================================================================
    -- USER: lua_ls config. Required for editing this nvim config without
    -- "undefined global 'vim'" warnings.
    -- -------------------------------------------------------------------------
    -- Pattern:
    --   vim.lsp.config("lua_ls", {
    --     settings = {
    --       Lua = {
    --         diagnostics = { globals = { "vim" } },
    --         completion = { callSnippet = "Replace" },
    --       },
    --     },
    --   })
    -- =========================================================================
    vim.lsp.config("lua_ls", {
      settings = {
        Lua = {
          diagnostics = { globals = { "vim" } },
          completion = { callSnippet = "Replace" },
          workspace = {
            -- expose Neovim runtime Lua files as library so lua_ls knows
            -- about vim.opt, vim.fn, vim.api, etc.
            library = vim.api.nvim_get_runtime_file("", true),
            checkThirdParty = false,
          },
        },
      },
    })

  end,
}
