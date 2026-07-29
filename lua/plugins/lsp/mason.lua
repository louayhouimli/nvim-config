return {
	"williamboman/mason.nvim",
	dependencies = {
		"williamboman/mason-lspconfig.nvim",
		"WhoIsSethDaniel/mason-tool-installer.nvim",
	},
	config = function()
		require("mason").setup({
			ui = {
				icons = {
					package_installed = "✓",
					package_pending = "➜",
					package_uninstalled = "✗",
				},
			},
		})

		require("mason-lspconfig").setup({
			ensure_installed = {
				-- web
				"ts_ls", -- TypeScript / JavaScript
				"html", -- HTML
				"cssls", -- CSS
				"tailwindcss", -- Tailwind CSS
				"emmet_ls", -- Emmet snippets in HTML/JSX
				-- config
				"lua_ls", -- Lua (used for editing this config)
				-- system programming
				"clangd", -- C / C++ (kernel dev, freestanding)
				"gopls", -- Go
			},
		})

		require("mason-tool-installer").setup({
			ensure_installed = {
				-- web formatter/linter
				"prettier", -- formatter for JS/TS/HTML/CSS/MD/YAML
				"stylua", -- formatter for Lua
				"eslint_d", -- linter for JS/TS (daemon flavor — fast)
				-- system programming formatter/linter
				"clang-format", -- formatter for C / C++
				"gofumpt", -- formatter for Go (stricter gofmt)
				"goimports", -- adds/removes Go imports
				"golangci-lint", -- meta-linter for Go (vet, staticcheck, etc.)
			},
		})
	end,
}
