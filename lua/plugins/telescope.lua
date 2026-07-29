return {
  "nvim-telescope/telescope.nvim",
  branch = "0.1.x",
  dependencies = {
    "nvim-lua/plenary.nvim",
    { "nvim-telescope/telescope-fzf-native.nvim", build = "make" },
    "nvim-tree/nvim-web-devicons",
    "folke/todo-comments.nvim",
  },
  config = function()
    -- Compat shim: telescope.nvim 0.1.x expects nvim-treesitter `master`
    -- branch's API — both `nvim-treesitter.parsers.ft_to_lang` / `.get_parser`
    -- and `nvim-treesitter.configs.is_enabled` / `.get_module`. The `main`
    -- branch removed all of these (parsers is now a data table; configs
    -- module no longer exists). We inject equivalents using built-in
    -- vim.treesitter so telescope's preview highlighting keeps working.
    -- Remove once telescope 0.1.x ships an upstream fix.
    do
      local ok, ts_parsers = pcall(require, "nvim-treesitter.parsers")
      if ok and type(ts_parsers) == "table" and ts_parsers.ft_to_lang == nil then
        ts_parsers.ft_to_lang = function(ft)
          return vim.treesitter.language.get_lang(ft)
        end
        ts_parsers.get_parser = function(bufnr, lang)
          return vim.treesitter.get_parser(bufnr or 0, lang)
        end
      end

      -- main branch has no `nvim-treesitter.configs` module — inject a stub
      -- into package.loaded so telescope's pcall require gets a usable table.
      local has_configs = pcall(require, "nvim-treesitter.configs")
      if not has_configs then
        package.loaded["nvim-treesitter.configs"] = {
          is_enabled = function() return true end,
          get_module = function() return {} end,
        }
      end
    end

    local telescope = require("telescope")
    local actions = require("telescope.actions")

    telescope.setup({
      defaults = {
        path_display = { "smart" },
        mappings = {
          i = {
            ["<C-k>"] = actions.move_selection_previous,
            ["<C-j>"] = actions.move_selection_next,
            ["<C-q>"] = actions.send_selected_to_qflist + actions.open_qflist,
          },
        },
      },
    })

    telescope.load_extension("fzf")

    local map = vim.keymap.set

    -- =====================================================================
    -- USER: telescope keymaps. Five mappings, all normal mode.
    -- ---------------------------------------------------------------------
    --   <leader>ff  ->  "<cmd>Telescope find_files<CR>"   "Fuzzy find files in cwd"
    --   <leader>fr  ->  "<cmd>Telescope oldfiles<CR>"     "Fuzzy find recent files"
    --   <leader>fs  ->  "<cmd>Telescope live_grep<CR>"    "Find string in cwd"
    --   <leader>fc  ->  "<cmd>Telescope grep_string<CR>"  "Find string under cursor in cwd"
    --   <leader>ft  ->  "<cmd>TodoTelescope<CR>"          "Find todos"
    -- =====================================================================
    map("n", "<leader>ff", "<cmd>Telescope find_files<CR>", { desc = "Fuzzy find files in cwd" })
    map("n", "<leader>fr", "<cmd>Telescope oldfiles<CR>", { desc = "Fuzzy find recent files" })
    map("n", "<leader>fs", "<cmd>Telescope live_grep<CR>", { desc = "Find string in cwd" })
    map("n", "<leader>fc", "<cmd>Telescope grep_string<CR>", { desc = "Find string under cursor in cwd" })
    map("n", "<leader>ft", "<cmd>TodoTelescope<CR>", { desc = "Find todos" })
  end,
}
