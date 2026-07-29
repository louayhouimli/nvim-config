# Neovim Config

Personal Neovim configuration for **Louay Houimli**, built on lazy.nvim. Focuses on TypeScript / web frontend, plus C / Go.

## Layout

```
init.lua                    # entry point: requires options, keymaps, lazy
lua/config/
  options.lua               # vim.opt.* settings
  keymaps.lua               # leader, splits, tabs, jk-to-ESC, etc.
  lazy.lua                  # lazy.nvim bootstrap + plugin spec import
lua/plugins/
  *.lua                     # one file per plugin (auto-imported by lazy)
  lsp/
    mason.lua               # LSP/formatter/linter installer
    lspconfig.lua           # LSP server wiring + LspAttach keymaps
```

## Stack

- **Bootstrap:** lazy.nvim
- **Colorscheme:** tokyonight (style: night, custom dark blue palette)
- **UI:** alpha (dashboard), lualine, bufferline (tabs mode), nvim-tree, which-key, dressing, indent-blankline, nvim-web-devicons
- **Editing:** treesitter (main branch), telescope (+ fzf-native), Comment.nvim, nvim-surround, nvim-autopairs, substitute.nvim, todo-comments, vim-maximizer
- **LSP / Completion:** mason + mason-lspconfig + mason-tool-installer, nvim-lspconfig, nvim-cmp + LuaSnip + lspkind, conform.nvim (format-on-save), nvim-lint
- **Git / Session:** gitsigns.nvim, auto-session, trouble.nvim
- **Misc:** vim-tmux-navigator, vim-wakatime

### Languages supported

| Language                            | LSP                                        | Format                  | Lint            | Treesitter |
| ----------------------------------- | ------------------------------------------ | ----------------------- | --------------- | ---------- |
| JavaScript / TypeScript / JSX / TSX | `ts_ls`                                    | `prettier`              | `eslint_d`      | ✓          |
| HTML / CSS                          | `html`, `cssls`, `tailwindcss`, `emmet_ls` | `prettier`              | —               | ✓          |
| JSON / YAML / Markdown              | —                                          | `prettier`              | —               | ✓          |
| Lua                                 | `lua_ls`                                   | `stylua`                | —               | ✓          |
| C / C++                             | `clangd`                                   | `clang-format`          | (LSP)           | ✓          |
| Go                                  | `gopls`                                    | `goimports` + `gofumpt` | `golangci-lint` | ✓          |
| Bash / Make / CMake / Dockerfile    | —                                          | —                       | —               | ✓          |

## Requirements

- Neovim **0.12+** (uses `vim.lsp.config()` API and `vim.diagnostic.jump()`)
- Git
- A **Nerd Font** in your terminal (FiraCode Nerd Font Mono recommended)
- `tree-sitter-cli` for parser builds: `brew install tree-sitter-cli`
- `ripgrep` for telescope `live_grep`
- A C compiler (Xcode CLT on macOS)
- For Go: `go` toolchain on PATH
- For C/C++ kernel work: `clangd` is installed via Mason, but you may want a `.clangd` file at project root with `-ffreestanding` flags

## First launch

```bash
nvim
```

Lazy.nvim will clone all plugins, Mason will download LSP/formatter binaries, and treesitter will compile parsers. Allow ~3–5 minutes on first run.

---

## Keymap reference

Leader key is **Space**. `<localleader>` is **`\`** (rarely used).

### General editing

| Keys               | Action                            | Where defined |
| ------------------ | --------------------------------- | ------------- |
| `jk` (insert mode) | Exit to normal mode               | keymaps.lua   |
| `<leader>nh`       | Clear search highlights (`:nohl`) | keymaps.lua   |
| `<leader>+`        | Increment number under cursor     | keymaps.lua   |
| `<leader>-`        | Decrement number under cursor     | keymaps.lua   |

### Window splits

| Keys                                  | Action                                            |
| ------------------------------------- | ------------------------------------------------- |
| `<leader>sv`                          | Split window vertically                           |
| `<leader>sh`                          | Split window horizontally                         |
| `<leader>se`                          | Make all splits equal size                        |
| `<leader>sx`                          | Close current split                               |
| `<leader>sm`                          | Maximize / minimize current split (vim-maximizer) |
| `<C-h>` / `<C-j>` / `<C-k>` / `<C-l>` | Move between splits and tmux panes                |

### Tab pages (vim tabs)

| Keys         | Action                         |
| ------------ | ------------------------------ |
| `<leader>to` | New tab                        |
| `<leader>tx` | Close current tab              |
| `<leader>tn` | Next tab                       |
| `<leader>tp` | Previous tab                   |
| `<leader>tf` | Open current buffer in new tab |

### File explorer (nvim-tree)

| Keys         | Action                          |
| ------------ | ------------------------------- |
| `<leader>e`  | Toggle file explorer            |
| `<leader>ef` | Toggle, jumping to current file |
| `<leader>ec` | Collapse all open folders       |
| `<leader>er` | Refresh tree                    |

### Telescope (fuzzy find)

| Keys         | Action                           |
| ------------ | -------------------------------- |
| `<leader>ff` | Fuzzy find files in cwd          |
| `<leader>fr` | Fuzzy find recently opened files |
| `<leader>fs` | Live grep in cwd                 |
| `<leader>fc` | Grep word under cursor in cwd    |
| `<leader>ft` | Find TODO/FIX/NOTE comments      |

Inside any telescope picker:

| Keys              | Action                            |
| ----------------- | --------------------------------- |
| `<C-j>` / `<C-k>` | Next / previous result            |
| `<C-q>`           | Send all results to quickfix list |

### LSP (only active in buffers with an LSP attached)

| Keys                  | Action                                       |
| --------------------- | -------------------------------------------- |
| `K` (Neovim built-in) | Hover documentation                          |
| `gD`                  | Go to declaration                            |
| `gd`                  | Show LSP definitions (Telescope)             |
| `gi`                  | Show LSP implementations                     |
| `gt`                  | Show LSP type definitions                    |
| `gR`                  | Show LSP references                          |
| `<leader>ca`          | Show code actions (works in normal & visual) |
| `<leader>rn`          | Smart rename symbol                          |
| `<leader>D`           | Show buffer diagnostics                      |
| `<leader>d`           | Show line diagnostics (floating)             |
| `[d` / `]d`           | Previous / next diagnostic                   |
| `<leader>rs`          | Restart the LSP for current buffer           |

### Completion (nvim-cmp, in insert mode)

| Keys              | Action                                                       |
| ----------------- | ------------------------------------------------------------ |
| `<C-Space>`       | Trigger completion menu                                      |
| `<C-j>` / `<C-k>` | Next / previous completion item                              |
| `<C-b>` / `<C-f>` | Scroll docs up / down                                        |
| `<C-e>`           | Abort completion menu                                        |
| `<CR>`            | Confirm selected item (does NOT confirm if nothing selected) |

### Format / Lint

| Keys         | Action                                                |
| ------------ | ----------------------------------------------------- |
| `<leader>mp` | Format current file or visual selection (conform)     |
| `<leader>l`  | Manually trigger linters for current file (nvim-lint) |
| `:w`         | Auto-format on save (conform; sync, 1s timeout)       |

### Git (gitsigns — only in git-tracked files)

| Keys                 | Action                                         |
| -------------------- | ---------------------------------------------- |
| `]h` / `[h`          | Next / previous git hunk                       |
| `<leader>hs` (n)     | Stage hunk under cursor                        |
| `<leader>hs` (v)     | Stage selected lines                           |
| `<leader>hr` (n / v) | Reset hunk / selection                         |
| `<leader>hS`         | Stage entire buffer                            |
| `<leader>hR`         | Reset entire buffer                            |
| `<leader>hp`         | Preview hunk diff (floating window)            |
| `<leader>hb`         | Blame current line (full info)                 |
| `<leader>hB`         | Toggle line blame in virtual text              |
| `<leader>hd`         | Diff this file vs index                        |
| `<leader>hD`         | Diff this file vs HEAD~                        |
| `ih` (text object)   | Inner hunk (`dih` deletes hunk, `vih` selects) |

### Diagnostics panel (trouble.nvim)

| Keys         | Action                                |
| ------------ | ------------------------------------- |
| `<leader>xw` | Workspace diagnostics                 |
| `<leader>xd` | Document (current buffer) diagnostics |
| `<leader>xq` | Quickfix list                         |
| `<leader>xl` | Location list                         |
| `<leader>xt` | TODO comments list                    |

### Comments

| Keys          | Action                                |
| ------------- | ------------------------------------- |
| `gcc`         | Toggle comment for current line       |
| `gc` (visual) | Toggle comment for selection          |
| `gcb`         | Block comment current line            |
| `]t` / `[t`   | Next / previous TODO/FIX/NOTE comment |

### Substitute (replace target with register contents)

| Keys                     | Action                                      |
| ------------------------ | ------------------------------------------- |
| `s<motion>` (e.g. `siw`) | Substitute text covered by motion with yank |
| `ss`                     | Substitute current line                     |
| `S`                      | Substitute from cursor to end of line       |
| `s` (visual)             | Substitute current selection                |

### Surround (nvim-surround)

| Keys               | Action                                                     |
| ------------------ | ---------------------------------------------------------- |
| `ys<motion><char>` | Add `<char>` around motion. e.g. `ysiw"` wraps word in `"` |
| `cs<old><new>`     | Change surrounding `<old>` to `<new>`. e.g. `cs"'`         |
| `ds<char>`         | Delete surrounding `<char>`. e.g. `ds(` removes parens     |

### Treesitter

Treesitter highlight, indent, and autotag (HTML/JSX) are automatic on FileType. No keymaps in this config — for incremental selection, install `nvim-treesitter-textobjects` separately.

### Sessions (auto-session)

| Keys         | Action                                |
| ------------ | ------------------------------------- |
| `<leader>wr` | Restore session for current directory |
| `<leader>ws` | Save session for current directory    |

Sessions are NOT auto-restored — call `<leader>wr` explicitly.

### Which-key

Press **`<Space>`** in normal mode and wait 500 ms — a popup lists all keymaps that start with the leader, organized by group. Same for `]` (next-style maps) and `[` (prev-style maps).
