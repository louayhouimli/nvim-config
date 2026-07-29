return {
  "nvim-lualine/lualine.nvim",
  dependencies = { "nvim-tree/nvim-web-devicons" },
  event = "VeryLazy",
  config = function()
    local lualine = require("lualine")
    local lazy_status = require("lazy.status") -- for lazy update indicator

    -- =====================================================================
    -- USER: tweak any hex color to taste, or accept defaults verbatim.
    -- ---------------------------------------------------------------------
    -- These map vim modes to colors used in the leftmost statusline cell.
    -- "semilightgray" is needed for the inactive split's statusline — the
    -- old config referenced it but never defined it (silently broken).
    -- =====================================================================
    local colors = {
      blue = "#65D1FF", -- normal mode
      green = "#3EFFDC", -- insert mode
      violet = "#FF61EF", -- visual mode
      yellow = "#FFDA7B", -- command mode
      red = "#FF4A4A", -- replace mode
      fg = "#c3ccdc", -- main statusline text
      bg = "#112638", -- main statusline background
      inactive_bg = "#2c3043", -- inactive split's statusline background
      semilightgray = "#8b95a7", -- inactive split's statusline text
    }

    local theme = {
      normal = {
        a = { bg = colors.blue, fg = colors.bg, gui = "bold" },
        b = { bg = colors.bg, fg = colors.fg },
        c = { bg = colors.bg, fg = colors.fg },
      },
      insert = {
        a = { bg = colors.green, fg = colors.bg, gui = "bold" },
        b = { bg = colors.bg, fg = colors.fg },
        c = { bg = colors.bg, fg = colors.fg },
      },
      visual = {
        a = { bg = colors.violet, fg = colors.bg, gui = "bold" },
        b = { bg = colors.bg, fg = colors.fg },
        c = { bg = colors.bg, fg = colors.fg },
      },
      command = {
        a = { bg = colors.yellow, fg = colors.bg, gui = "bold" },
        b = { bg = colors.bg, fg = colors.fg },
        c = { bg = colors.bg, fg = colors.fg },
      },
      replace = {
        a = { bg = colors.red, fg = colors.bg, gui = "bold" },
        b = { bg = colors.bg, fg = colors.fg },
        c = { bg = colors.bg, fg = colors.fg },
      },
      inactive = {
        a = { bg = colors.inactive_bg, fg = colors.semilightgray, gui = "bold" },
        b = { bg = colors.inactive_bg, fg = colors.semilightgray },
        c = { bg = colors.inactive_bg, fg = colors.semilightgray },
      },
    }

    lualine.setup({
      options = { theme = theme },
      sections = {
        lualine_x = {
          {
            lazy_status.updates,
            cond = lazy_status.has_updates,
            color = { fg = "#ff9e64" },
          },
          { "encoding" },
          { "fileformat" },
          { "filetype" },
          {
            function() return vim.fn["wakatime#statusline"]() end,
            cond = function() return vim.fn.exists("*wakatime#statusline") == 1 end,
          },
        },
      },
    })
  end,
}
