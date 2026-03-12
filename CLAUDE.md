# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Project Purpose

This is a **multi-machine configuration repo** — Neovim, terminal, shell, and dev tools configs managed in one place. Based on kickstart.nvim, extended with custom plugins, terminal theming, and installer scripts. Deployed across three machines: NBIQ (work laptop), SUNDANCE (home PC), and linux-lab (Ubuntu server).

## Key Files

| File | Purpose |
|------|---------|
| `machines.json` | Per-machine settings (paths, OS, shell, font flags) |
| `CATALOGUE.md` | Full inventory of everything installed and configured |
| `init.lua` | Neovim config (single-file, machine-specific lines patched at setup) |
| `terminal/` | Windows Terminal settings, Oh My Posh theme, PowerShell profile, installer |

## First-Time Setup on a New Machine

When Claude Code is run on this repo for the first time on a machine:

1. **Identify the machine** — run `hostname` and match against `machines.json` `hostname_pattern` values.
2. **If the machine exists in `machines.json` but has empty fields** — detect and fill them:
   - `user`: `whoami` or `$env:USERNAME`
   - `home`: `$HOME` or `$env:USERPROFILE`
   - `repo_path`: the current working directory (where this repo is cloned)
   - `nvim_config_path`: `$LOCALAPPDATA\nvim` (Windows) or `~/.config/nvim` (Linux)
   - `default_directory`: ask the user what their preferred working directory is
   - `terminal_settings_path`: detect Windows Terminal install path
   - `powershell_profile`: `$PROFILE` in PowerShell
3. **If the machine is not in `machines.json`** — add a new entry with all detected values.
4. **Commit the updated `machines.json`** so it's available on all machines via git.
5. **Run `/setup-nvim`** to patch `init.lua` and install everything.

### Machine-Specific Lines in init.lua

These lines change per machine. Match on content patterns (not line numbers) when patching:

| Pattern | Windows | Linux |
|---------|---------|-------|
| `vim.cmd('cd ...')` | Set to `default_directory` from `machines.json` | Set to `default_directory` from `machines.json` |
| `vim.o.shell = 'pwsh'` block (4 lines) | Keep | Remove entirely |
| `vim.g.have_nerd_font` | `true` if Nerd Font installed | `false` unless installed |
| `<leader>tp` terminal keymap | Keep as `<leader>tp` | Change to `<leader>tt`, remove `[P]owershell` from desc |

### Syncing Config to Neovim

After ANY change to config files, copy to the Neovim config location from `machines.json`:

```bash
# Use nvim_config_path from machines.json for the target
# Windows (Git Bash)
cp -r /path/to/repo/* /c/Users/<user>/AppData/Local/nvim/

# Linux
cp -r /path/to/repo/* ~/.config/nvim/
```

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

See `CATALOGUE.md` for the full plugin inventory. Key layers:

| Layer | Plugin | Purpose |
|---|---|---|
| Fuzzy finder | `telescope.nvim` | File search, grep, LSP navigation, help search |
| LSP | `nvim-lspconfig` + `mason.nvim` + `mason-tool-installer` | Language servers, auto-install |
| Completion | `blink.cmp` + `LuaSnip` | Autocompletion with snippet support |
| Formatting | `conform.nvim` | Format-on-save (StyLua for Lua, extensible) |
| Syntax | `nvim-treesitter` | Treesitter-based highlighting |
| Theme | `tokyonight.nvim` | Tokyo Night with custom colors, transparent bg |
| Git | `gitsigns.nvim` | Gutter signs, hunk navigation |
| UI | `which-key.nvim`, `lualine`, `bufferline`, `dressing` | Key hints, statusline, buffer tabs |
| Utilities | `mini.ai`, `mini.surround`, `guess-indent`, `todo-comments` | Text objects, surroundings, indentation |

### Extending the Config

**Optional built-in plugins** live in `lua/kickstart/plugins/` and are enabled by uncommenting `require` lines in `init.lua`'s lazy.setup call.

**Custom user plugins** go in `lua/custom/plugins/*.lua` — enabled via `{ import = 'custom.plugins' }` in init.lua.

### LSP Configuration Pattern

LSP servers are defined in the `servers` table inside the `nvim-lspconfig` config function. To add a language:
1. Add the server name and config to the `servers` table (e.g., `pyright = {}`)
2. Mason auto-installs it
3. `lua_ls` has special workspace config for Neovim Lua development — handled separately below the servers table

### Key Leader Mappings

All major keymaps use `<Space>` as leader:
- `<leader>s*` — Search (Telescope): files, grep, help, keymaps, diagnostics, buffers
- `<leader>h*` — Git hunk operations
- `<leader>t*` — Tabs, terminal, toggles
- `<leader>sv/sh/se/sx` — Split management
- `<leader>f` — Format buffer
- `<leader>q` — Diagnostic quickfix list
- `gr*` — LSP: references, implementations, definitions, rename, code action

### Health Check

Run `:checkhealth kickstart` in Neovim to verify the system setup. The health module (`lua/kickstart/health.lua`) checks for Neovim >= 0.11 and required executables (git, make, unzip, rg).

## Windows Notes

- `vim.g.have_nerd_font` defaults to `false` — set to `true` if a Nerd Font is installed
- LuaSnip's jsregexp build step is skipped on Windows by default
- DAP/delve runs attached (not detached) on Windows to avoid crashes
- Clipboard syncs via `unnamedplus` (requires win32yank or similar)
- Shell set to `pwsh` (PowerShell 7 must be in PATH)
- `tree-sitter` + `zig` needed for treesitter parser compilation

## Linux Notes

- Default shell used (no shell config lines in init.lua)
- `build-essential` provides the C compiler for treesitter
- May need Neovim PPA for version >= 0.11
