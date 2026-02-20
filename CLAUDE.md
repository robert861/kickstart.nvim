# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Project Purpose

This is a **personal Neovim configuration** based on kickstart.nvim — a documented starting point (not a distribution) meant to be read top-to-bottom, understood, and customized. The owner is learning Neovim and will be iterating on this config over time.

## Formatting and Linting

- Lua code is formatted with **StyLua** (`stylua --check .` to verify, `stylua .` to fix)
- CI enforces StyLua formatting on PRs
- Modeline convention: `-- vim: ts=2 sts=2 sw=2 et` (2-space indent, spaces not tabs)

## Architecture

### Entry Point

`init.lua` is the single main configuration file. It contains (in order):
1. **Leader key** setup (`<Space>` for both leader and localleader)
2. **Vim options** (`vim.o.*` settings)
3. **Core keymaps** (search clear, diagnostics, terminal escape, window navigation)
4. **Autocommands** (yank highlight)
5. **lazy.nvim bootstrap** (plugin manager, auto-installs itself)
6. **Plugin specifications** passed to `require('lazy').setup()`

### Plugin Manager

[lazy.nvim](https://github.com/folke/lazy.nvim) manages all plugins. Key commands:
- `:Lazy` — view plugin status
- `:Lazy update` — update all plugins
- `:Mason` — view/install LSP servers and tools

### Plugin Stack

| Layer | Plugin | Purpose |
|---|---|---|
| Fuzzy finder | `telescope.nvim` | File search, grep, LSP navigation, help search |
| LSP | `nvim-lspconfig` + `mason.nvim` + `mason-tool-installer` | Language servers, auto-install |
| Completion | `blink.cmp` + `LuaSnip` | Autocompletion with snippet support |
| Formatting | `conform.nvim` | Format-on-save (StyLua for Lua, extensible) |
| Syntax | `nvim-treesitter` | Treesitter-based highlighting |
| Git | `gitsigns.nvim` | Gutter signs, hunk navigation |
| UI | `which-key.nvim`, `mini.statusline`, `tokyonight` | Key hints, statusline, colorscheme |
| Utilities | `mini.ai`, `mini.surround`, `guess-indent`, `todo-comments` | Text objects, surroundings, indentation |

### Extending the Config

**Optional built-in plugins** live in `lua/kickstart/plugins/` and are enabled by uncommenting `require` lines in `init.lua`'s lazy.setup call:
- `debug` — DAP debugger setup (Go-focused, extensible)
- `indent_line` — indentation guides
- `lint` — nvim-lint (markdownlint by default)
- `autopairs` — auto-close brackets/quotes
- `neo-tree` — file explorer sidebar (toggle with `\`)
- `gitsigns` — extended gitsigns keymaps (hunk stage/reset/blame)

**Custom user plugins** go in `lua/custom/plugins/*.lua` — enable by uncommenting `{ import = 'custom.plugins' }` in init.lua. This directory is merge-conflict-safe.

### LSP Configuration Pattern

LSP servers are defined in the `servers` table inside the `nvim-lspconfig` config function. To add a language:
1. Add the server name and config to the `servers` table (e.g., `pyright = {}`)
2. Mason auto-installs it
3. `lua_ls` has special workspace config for Neovim Lua development — handled separately below the servers table

### Key Leader Mappings

All major keymaps use `<Space>` as leader. The `[S]earch` notation in descriptions indicates which-key grouping:
- `<leader>s*` — Search (Telescope): files, grep, help, keymaps, diagnostics, buffers
- `<leader>h*` — Git hunk operations (when gitsigns keymaps plugin enabled)
- `<leader>t*` — Toggle: inlay hints, git blame
- `<leader>f` — Format buffer
- `<leader>q` — Diagnostic quickfix list
- `gr*` — LSP: references, implementations, definitions, rename, code action

### Health Check

Run `:checkhealth kickstart` in Neovim to verify the system setup. The health module (`lua/kickstart/health.lua`) checks for Neovim >= 0.11 and required executables (git, make, unzip, rg).

### Machine-Specific Settings

These lines in `init.lua` change per machine. The `/setup-nvim` skill patches them during setup. If line numbers shift, match on the content patterns instead.

| Line | Setting | Windows | Linux |
|------|---------|---------|-------|
| 88 | Default directory | `vim.cmd('cd G:\\Claude')` | `vim.cmd('cd /home/user/projects')` |
| 91-94 | Shell config | PowerShell (`pwsh`) block | Remove (use default shell) |
| 104 | Nerd Font flag | `false` or `true` | `false` or `true` |
| 211 | Terminal keymap | `terminal pwsh` | `terminal` (and `<leader>tt` instead of `<leader>tp`) |

## Dual Config Locations

The repo lives at `G:\claude\kickstart.nvim\`. Neovim reads its config from a platform-specific path:
- **Windows:** `C:\Users\BAILEY\AppData\Local\nvim\` (i.e., `$LOCALAPPDATA\nvim\`)
- **Linux:** `~/.config/nvim/`

These two directories must stay in sync. **After ANY change to config files**, copy the changed files to the Neovim config location:

```bash
# Windows (Git Bash)
cp -r G:/claude/kickstart.nvim/* C:/Users/BAILEY/AppData/Local/nvim/

# Linux
cp -r /path/to/repo/* ~/.config/nvim/
```

Always verify both copies match before finishing.

## Windows Notes

- `vim.g.have_nerd_font` defaults to `false` — set to `true` if a Nerd Font is installed
- LuaSnip's jsregexp build step is skipped on Windows by default
- DAP/delve runs attached (not detached) on Windows to avoid crashes
- Clipboard syncs via `unnamedplus` (requires win32yank or similar)
