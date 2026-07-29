return {
	{
		"folke/tokyonight.nvim",
		priority = 1000, -- load before any UI plugin draws
		lazy = false,
		config = function()
			-- =====================================================================
			-- USER: tweak any of these hex values to taste, or accept defaults.
			-- ---------------------------------------------------------------------
			-- These overrides are passed into tokyonight's `on_colors` hook.
			-- Defaults below match the previous config's deep-blue palette.
			-- Every "bg_*" sets a UI surface; every "fg_*" sets a text class.
			-- =====================================================================
			local bg = "#000b15" -- main editor background (only visible if transparent = false)
			local bg_dark = "#011423" -- floats, sidebar, statusline backdrop
			local bg_highlight = "#143652" -- cursorline, matched paren
			local bg_search = "#0A64AC" -- /search highlight
			local bg_visual = "#275378" -- visual-mode selection
			local fg = "#CBE0F0" -- main text
			local fg_dark = "#B4D0E9" -- secondary text (statusline labels)
			local fg_gutter = "#627E97" -- line numbers, sign column
			local border = "#547998" -- floats and split borders

			require("tokyonight").setup({
				transparent = false, -- USER: set false if you want `bg` to actually paint
				style = "moon", -- USER: alternatives — "storm", "moon", "day"
				on_colors = function(colors)
					colors.bg = bg
					colors.bg_dark = bg_dark
					colors.bg_float = bg_dark
					colors.bg_highlight = bg_highlight
					colors.bg_popup = bg_dark
					colors.bg_search = bg_search
					colors.bg_sidebar = bg_dark
					colors.bg_statusline = bg_dark
					colors.bg_visual = bg_visual
					colors.border = border
					colors.fg = fg
					colors.fg_dark = fg_dark
					colors.fg_float = fg
					colors.fg_gutter = fg_gutter
					colors.fg_sidebar = fg_dark
				end,
			})

			vim.cmd("colorscheme tokyonight")
		end,
	},
}
