return {
  "hrsh7th/nvim-cmp",
  event = "InsertEnter",
  dependencies = {
    "hrsh7th/cmp-buffer", -- words from current buffer
    "hrsh7th/cmp-path", -- filesystem paths
    {
      "L3MON4D3/LuaSnip",
      version = "v2.*",
      build = "make install_jsregexp",
    },
    "saadparwaiz1/cmp_luasnip", -- bridge LuaSnip <-> cmp
    "rafamadriz/friendly-snippets", -- VSCode-style snippet bundle
    "onsails/lspkind.nvim", -- VSCode-style icons in completion menu
  },
  config = function()
    local cmp = require("cmp")
    local luasnip = require("luasnip")
    local lspkind = require("lspkind")

    -- load VSCode-style snippets from friendly-snippets and similar plugins
    require("luasnip.loaders.from_vscode").lazy_load()

    cmp.setup({
      completion = {
        completeopt = "menu,menuone,preview,noselect",
      },
      snippet = {
        expand = function(args)
          luasnip.lsp_expand(args.body)
        end,
      },

      -- =====================================================================
      -- USER: cmp keymaps. Seven mappings inside cmp.mapping.preset.insert({...}).
      -- ---------------------------------------------------------------------
      -- Required (same as old config):
      --
      --   ["<C-k>"]     = cmp.mapping.select_prev_item(),
      --   ["<C-j>"]     = cmp.mapping.select_next_item(),
      --   ["<C-b>"]     = cmp.mapping.scroll_docs(-4),
      --   ["<C-f>"]     = cmp.mapping.scroll_docs(4),
      --   ["<C-Space>"] = cmp.mapping.complete(),
      --   ["<C-e>"]     = cmp.mapping.abort(),
      --   ["<CR>"]      = cmp.mapping.confirm({ select = false }),
      --
      -- Note the trailing commas inside the table; the outer parens close
      -- cmp.mapping.preset.insert(...).
      -- =====================================================================
      mapping = cmp.mapping.preset.insert({
        ["<C-k>"] = cmp.mapping.select_prev_item(),
        ["<C-j>"] = cmp.mapping.select_next_item(),
        ["<C-b>"] = cmp.mapping.scroll_docs(-4),
        ["<C-f>"] = cmp.mapping.scroll_docs(4),
        ["<C-Space>"] = cmp.mapping.complete(),
        ["<C-e>"] = cmp.mapping.abort(),
        ["<CR>"] = cmp.mapping.confirm({ select = false }),
      }),

      sources = cmp.config.sources({
        { name = "nvim_lsp" }, -- LSP completion
        { name = "luasnip" }, -- snippets
        { name = "buffer" }, -- words in current buffer
        { name = "path" }, -- filesystem paths
      }),

      formatting = {
        format = lspkind.cmp_format({
          maxwidth = 50,
          ellipsis_char = "...",
        }),
      },
    })
  end,
}
