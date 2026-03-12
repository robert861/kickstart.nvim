# Configuration Catalogue

Everything we've installed, configured, and customized — tracked so it can be reproduced on any machine.

## Theme: Tokyo Night (unified across all tools)

| Tool | Config File | Details |
|------|-------------|---------|
| Neovim | `init.lua` | `tokyonight.nvim` with josean-dev custom colors, transparent background |
| Windows Terminal | `terminal/windows-terminal-settings.json` | Tokyo Night color scheme + theme, acrylic opacity 90/80 |
| Oh My Posh | `terminal/tokyonight.omp.json` | Tokyo Night prompt theme |
| Windows accent | Manual | `#7aa2f7` (Tokyo Night blue) for pane focus borders |

## Neovim Configuration

### Core Settings (init.lua)
- **Leader key:** `<Space>`
- **Relative line numbers:** enabled
- **Nerd Font:** enabled (machine-dependent, see `machines.json`)
- **Transparent background:** enabled
- **Clipboard:** synced via `unnamedplus`
- **Shell:** `pwsh` on Windows, default on Linux
- **Default directory:** machine-specific (see `machines.json`)

### Custom Keymaps (beyond kickstart defaults)
| Keymap | Mode | Action |
|--------|------|--------|
| `jk` | Insert | Exit insert mode |
| `<leader>+` / `<leader>-` | Normal | Increment/decrement number |
| `<leader>sv/sh/se/sx` | Normal | Split vertical/horizontal/equal/close |
| `<leader>to/tx/tn/tb/tf` | Normal | Tab open/close/next/back/current-file |
| `<leader>tp` | Normal | Terminal PowerShell split (Windows) |
| `<leader>ta` | Normal | Toggle autocomplete |

### Plugin Stack

#### Kickstart Built-in (enabled)
| Plugin | Purpose |
|--------|---------|
| `indent_line` | Indentation guides |
| `autopairs` | Auto-close brackets/quotes |
| `neo-tree` | File explorer sidebar (`\` to toggle) |
| `gitsigns` | Extended git keymaps (hunk stage/reset/blame) |
| `dashboard` | Startup dashboard via snacks.nvim |

#### Kickstart Built-in (disabled)
| Plugin | Purpose |
|--------|---------|
| `debug` | DAP debugger (Go-focused) |
| `lint` | nvim-lint (markdownlint) |

#### Custom Plugins (`lua/custom/plugins/`)
| Plugin | File | Purpose |
|--------|------|---------|
| Bufferline | `bufferline.lua` | Tab-style buffer bar |
| GitHub Copilot | `copilot.lua` | AI code completion with toggle |
| Dressing | `dressing.lua` | Improved UI for input/select |
| LazyGit | `lazygit.lua` | Git TUI integration |
| Lualine | `lualine.lua` | Statusline (replaces mini.statusline) |
| Treesitter Textobjects | `treesitter-textobjects.lua` | Enhanced text objects |
| Trouble | `trouble.lua` | Better diagnostics list |
| Vim Maximizer | `vim-maximizer.lua` | Toggle maximize split |

### Mason Tools (auto-installed)
| Tool | Type |
|------|------|
| `lua-language-server` | LSP |
| `pyright` | LSP |
| `typescript-language-server` | LSP |
| `bash-language-server` | LSP |
| `json-lsp` | LSP |
| `stylua` | Formatter |
| `ruff` | Linter/Formatter (requires Python) |
| `prettierd` | Formatter |

## Terminal Configuration (Windows)

### Windows Terminal
- **Font:** JetBrainsMono Nerd Font, size 11
- **Color scheme:** Tokyo Night (custom scheme in settings)
- **Opacity:** 90% focused, 80% unfocused (acrylic)
- **Default profile:** PowerShell 7 (pwsh)
- **Scrollbar:** hidden
- **Copy on select:** enabled
- **Focus follows mouse:** enabled
- **Keybindings:** Ctrl+C copy, Ctrl+V paste, Ctrl+Shift+F find, Alt+Shift+D duplicate pane

### Oh My Posh
- **Theme:** Tokyo Night (`terminal/tokyonight.omp.json`)
- **Installed via:** winget (`JanDeDobbeleer.OhMyPosh`)

### PowerShell Profile
- Oh My Posh init with Tokyo Night theme
- zoxide init (`cd` aliased to `z`)
- eza alias for `ls` (long format, git status, icons, no clutter)
- fzf config with fd backend, Tokyo Night color scheme, eza/bat previews
- bat theme set to `tokyonight_night`
- **PSFzf module** — bridges fzf with PSReadLine for shell keybindings:
  - `Ctrl+T` — fuzzy file search (with bat preview)
  - `Alt+C` — fuzzy directory jump (with eza tree preview)
  - `Ctrl+R` — fuzzy command history search
  - Install: `Install-PSResource -Name PSFzf -Scope CurrentUser -TrustRepository`
- Profile location: `$PROFILE` (usually `Documents\PowerShell\Microsoft.PowerShell_profile.ps1`)

## System Dependencies

### Windows (via scoop)
| Package | Purpose |
|---------|---------|
| `neovim` | Editor |
| `ripgrep` | Fast grep (required by Telescope) |
| `python` | Required for ruff LSP |
| `ruff` | Python linter/formatter |
| `tree-sitter` | Parser compiler for nvim-treesitter |
| `zig` | C compiler backend for tree-sitter on Windows |
| `fzf` | Fuzzy finder (Ctrl+T files, Alt+C dirs) |
| `fd` | Fast find (fzf backend, replaces default find) |
| `eza` | Modern ls replacement (icons, git, tree) |
| `zoxide` | Smarter cd (learns frequent directories) |
| `bat` | Cat with syntax highlighting (fzf file preview) |

### Linux (via apt)
| Package | Purpose |
|---------|---------|
| `neovim` | Editor (may need PPA for latest) |
| `ripgrep` | Fast grep |
| `python3` | Required for ruff |
| `build-essential` | C compiler for treesitter |
| `unzip` | Required by Mason |

### Nerd Font
- **Font:** JetBrainsMono Nerd Font
- **Windows install:** `scoop bucket add nerd-fonts && scoop install nerd-fonts/JetBrainsMono-NF`
- **Linux install:** Download from [nerdfonts.com](https://www.nerdfonts.com/) or use oh-my-posh font installer

### PowerShell Modules
| Module | Install Command | Purpose |
|--------|----------------|---------|
| `PSFzf` | `Install-PSResource -Name PSFzf -Scope CurrentUser -TrustRepository` | Bridges fzf with PSReadLine (Ctrl+T, Alt+C, Ctrl+R) |

## New Machine Setup Checklist (Windows)

1. **Install scoop packages:** `scoop install neovim ripgrep python ruff tree-sitter zig fzf fd eza zoxide bat`
2. **Install Nerd Font:** `scoop bucket add nerd-fonts && scoop install nerd-fonts/JetBrainsMono-NF`
3. **Install PSFzf module:** `Install-PSResource -Name PSFzf -Scope CurrentUser -TrustRepository`
4. **Run terminal installer:** `terminal/install.ps1` (Windows Terminal settings, Oh My Posh theme)
5. **Copy PowerShell profile:** `cp terminal/Microsoft.PowerShell_profile.ps1 $PROFILE`
6. **Run `/setup-nvim`** to patch init.lua and install Neovim plugins + Mason tools
7. **Restart terminal** and verify: `ls` (eza), `lt` (tree), `Ctrl+T` (fzf files), `Alt+C` (fzf dirs), `Ctrl+R` (fzf history)

## Installer Scripts
| Script | Purpose |
|--------|---------|
| `terminal/install.ps1` | Windows Terminal + Oh My Posh + font setup |
| `/setup-nvim` skill | Full Neovim setup (deps, config copy, Mason tools) |
