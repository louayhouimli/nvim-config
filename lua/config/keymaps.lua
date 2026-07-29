-- Leader keys MUST be set before lazy.setup() runs (which happens in
-- lua/config/lazy.lua). Since init.lua requires this file before lazy.lua,
-- the order is correct.
vim.g.mapleader = " "
vim.g.maplocalleader = "\\"

local map = vim.keymap.set

-- ===========================================================================
-- USER: Insert-mode escape
-- ---------------------------------------------------------------------------
-- One mapping. Pressing `jk` while in insert mode should exit to normal mode.
-- Shape:
--   map(<mode>, <lhs>, <rhs>, { desc = <description> })
-- Hint: mode = "i", lhs = "jk", rhs = "<ESC>".
-- ===========================================================================
map("i", "jk", "<ESC>", { desc = "Exit insert mode with jk" })

-- ===========================================================================
-- USER: Clear search highlights
-- ---------------------------------------------------------------------------
-- One mapping in normal mode. <leader>nh runs `:nohl<CR>`.
-- Don't forget the desc — which-key reads it.
-- ===========================================================================
map("n", "<leader>nh", ":nohl<CR>", { desc = "Clear search highlights" })

-- ===========================================================================
-- USER: Increment / decrement number under cursor
-- ---------------------------------------------------------------------------
-- Two mappings. <C-a> and <C-x> are vim's built-in increment/decrement, but
-- we shadow them with leader-prefixed versions to free up <C-a> for terminal
-- multiplexer prefix usage.
--
-- <leader>+   ->  "<C-a>"   desc: "Increment number"
-- <leader>-   ->  "<C-x>"   desc: "Decrement number"
-- ===========================================================================
map("n", "<leader>+", "<C-a>", { desc = "Increment number" })
map("n", "<leader>-", "<C-x>", { desc = "Decrement number" })

-- ===========================================================================
-- USER: Window management
-- ---------------------------------------------------------------------------
-- Four mappings, all normal mode:
--   <leader>sv  ->  "<C-w>v"          desc: "Split window vertically"
--   <leader>sh  ->  "<C-w>s"          desc: "Split window horizontally"
--   <leader>se  ->  "<C-w>="          desc: "Make splits equal size"
--   <leader>sx  ->  "<cmd>close<CR>"  desc: "Close current split"
-- ===========================================================================
map("n", "<leader>sv", "<C-w>v", { desc = "Split window vertically" })
map("n", "<leader>sh", "<C-w>s", { desc = "Split window horizontally" })
map("n", "<leader>se", "<C-w>=", { desc = "Make splits equal size" })
map("n", "<leader>sx", "<cmd>close<CR>", { desc = "Close current split" })

-- ===========================================================================
-- USER: Tab management
-- ---------------------------------------------------------------------------
-- Five mappings, all normal mode. Note: these are vim TAB PAGES, not buffer
-- tabs. Bufferline (Phase 3) renders them along the top.
--
--   <leader>to  ->  "<cmd>tabnew<CR>"       desc: "Open new tab"
--   <leader>tx  ->  "<cmd>tabclose<CR>"     desc: "Close current tab"
--   <leader>tn  ->  "<cmd>tabn<CR>"         desc: "Go to next tab"
--   <leader>tp  ->  "<cmd>tabp<CR>"         desc: "Go to previous tab"
--   <leader>tf  ->  "<cmd>tabnew %<CR>"     desc: "Open current buffer in new tab"
-- ===========================================================================
map("n", "<leader>to", "<cmd>tabnew<CR>", { desc = "Open new tab" })
map("n", "<leader>tx", "<cmd>tabclose<CR>", { desc = "Close current tab" })
map("n", "<leader>tn", "<cmd>tabn<CR>", { desc = "Go to next tab" })
map("n", "<leader>tp", "<cmd>tabp<CR>", { desc = "Go to previous tab" })
map("n", "<leader>tf", "<cmd>tabnew %<CR>", { desc = "Open current buffer in new tab" })
