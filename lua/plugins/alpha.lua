return {
  "goolord/alpha-nvim",
  event = "VimEnter",
  config = function()
    local alpha = require("alpha")
    local dashboard = require("alpha.themes.dashboard")

    -- header is the big NEOVIM banner; keep as-is
    dashboard.section.header.val = {
      "                                                     ",
      "  ███╗   ██╗███████╗ ██████╗ ██╗   ██╗██╗███╗   ███╗ ",
      "  ████╗  ██║██╔════╝██╔═══██╗██║   ██║██║████╗ ████║ ",
      "  ██╔██╗ ██║█████╗  ██║   ██║██║   ██║██║██╔████╔██║ ",
      "  ██║╚██╗██║██╔══╝  ██║   ██║╚██╗ ██╔╝██║██║╚██╔╝██║ ",
      "  ██║ ╚████║███████╗╚██████╔╝ ╚████╔╝ ██║██║ ╚═╝ ██║ ",
      "  ╚═╝  ╚═══╝╚══════╝ ╚═════╝   ╚═══╝  ╚═╝╚═╝     ╚═╝ ",
      "                                                     ",
    }

    -- =====================================================================
    -- USER: dashboard buttons.
    -- ---------------------------------------------------------------------
    -- Each entry follows: dashboard.button(<key>, <label>, <command>)
    --
    --   <key>     The shortcut shown on the left (e.g. "e", "SPC ee", "q").
    --             Must match the keymap that triggers <command>. "SPC" is
    --             the visual stand-in for <leader>; the actual key the user
    --             presses is whatever <leader> is bound to.
    --   <label>   Display text for the button. Icons (Nerd Font glyphs) are
    --             allowed at the start.
    --   <command> Vim command to run when the button is activated.
    --
    -- Suggested set (matches the previous config):
    --   "e"      "  > New File"                          "<cmd>ene<CR>"
    --   "SPC ee" "  > Toggle file explorer"              "<cmd>NvimTreeToggle<CR>"
    --   "SPC ff" "󰱼 > Find File"                         "<cmd>Telescope find_files<CR>"
    --   "SPC fs" "  > Find Word"                         "<cmd>Telescope live_grep<CR>"
    --   "SPC wr" "󰁯  > Restore Session For Current Directory"  "<cmd>SessionRestore<CR>"
    --   "q"      " > Quit NVIM"                          "<cmd>qa<CR>"
    -- =====================================================================
    dashboard.section.buttons.val = {
      dashboard.button("e", "> New File", "<cmd>ene<CR>"),
      dashboard.button("SPC ee", "> Toggle file explorer", "<cmd>NvimTreeToggle<CR>"),
      dashboard.button("SPC ff", "> Find File", "<cmd>Telescope find_files<CR>"),
      dashboard.button("SPC fs", "> Find Word", "<cmd>Telescope live_grep<CR>"),
      dashboard.button("SPC wr", "> Restore Session For Current Directory", "<cmd>SessionRestore<CR>"),
      dashboard.button("q", "> Quit NVIM", "<cmd>qa<CR>"),
    }

    alpha.setup(dashboard.opts)

    -- disable folding on the alpha buffer (the ASCII header confuses folds)
    vim.api.nvim_create_autocmd("FileType", {
      pattern = "alpha",
      callback = function()
        vim.opt_local.foldenable = false
      end,
    })
  end,
}
