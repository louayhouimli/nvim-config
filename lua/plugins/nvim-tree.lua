return {
	"nvim-tree/nvim-tree.lua",
	dependencies = { "nvim-tree/nvim-web-devicons" },
	config = function()
		-- disable netrw (vim's built-in file browser) BEFORE nvim-tree initializes
		vim.g.loaded_netrw = 1
		vim.g.loaded_netrwPlugin = 1

		require("nvim-tree").setup({
			view = {
				width = 35,
				relativenumber = true,
			},
			renderer = {
				indent_markers = { enable = true },
				icons = {
					glyphs = {
						folder = {
							arrow_closed = "",
							arrow_open = "",
						},
					},
				},
			},
			actions = {
				open_file = {
					window_picker = { enable = false },
				},
			},
			filters = {
				custom = { ".DS_Store" },
			},
			git = { ignore = false },
		})

		local map = vim.keymap.set

		-- =====================================================================
		-- USER: nvim-tree keymaps. Same pattern as Phase 1 keymaps.
		-- ---------------------------------------------------------------------
		-- Four mappings, all normal mode:
		--   <leader>ee  ->  "<cmd>NvimTreeToggle<CR>"          desc: "Toggle file explorer"
		--   <leader>ef  ->  "<cmd>NvimTreeFindFileToggle<CR>"  desc: "Toggle file explorer on current file"
		--   <leader>ec  ->  "<cmd>NvimTreeCollapse<CR>"        desc: "Collapse file explorer"
		--   <leader>er  ->  "<cmd>NvimTreeRefresh<CR>"         desc: "Refresh file explorer"
		-- =====================================================================
		map("n", "<leader>e", "<cmd>NvimTreeToggle<CR>", { desc = "Toggle file explorer" })
		map("n", "<leader>ef", "<cmd>NvimTreeFindFileToggle<CR>", { desc = "Toggle file explorer on current file" })
		map("n", "<leader>ec", "<cmd>NvimTreeCollapse<CR>", { desc = "Collapse file explorer" })
		map("n", "<leader>er", "<cmd>NvimTreeRefresh<CR>", { desc = "Refresh file explorer" })
	end,
}
