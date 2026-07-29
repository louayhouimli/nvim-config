-- nvim-treesitter `main` branch (the rewrite) — required for Neovim 0.12+.
-- The legacy `master` branch is incompatible with the conceal_line decoration
-- provider added in 0.12 (calls node:range() in contexts where master returns
-- nil, throwing per-redraw errors).
return {
	"nvim-treesitter/nvim-treesitter",
	branch = "main",
	build = ":TSUpdate",
	lazy = false,
	dependencies = {
		"windwp/nvim-ts-autotag",
	},
	config = function()
		-- Install parsers. Idempotent — re-runs are no-ops if already installed.
		require("nvim-treesitter").install({
			-- web
			"json",
			"javascript",
			"typescript",
			"tsx",
			"yaml",
			"html",
			"css",
			-- docs / data
			"markdown",
			"markdown_inline",
			-- shell / config
			"bash",
			"dockerfile",
			"gitignore",
			"make", -- Makefile
			"cmake", -- CMakeLists.txt
			-- editor / nvim config
			"lua",
			"vim",
			"query",
			"vimdoc",
			-- system programming
			"c",
			"cpp", -- C++ (clangd handles both)
			"go",
		})

		-- Start treesitter highlighting + indent + folding on every FileType.
		-- pcall wraps in case a buffer has a filetype with no installed parser.
		vim.api.nvim_create_autocmd("FileType", {
			group = vim.api.nvim_create_augroup("user_treesitter_start", { clear = true }),
			callback = function(args)
				local bufnr = args.buf
				pcall(vim.treesitter.start, bufnr)
				-- enable treesitter-based indent (replaces vim's regex indent)
				vim.bo[bufnr].indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
			end,
		})

		require("nvim-ts-autotag").setup({})
	end,
}
