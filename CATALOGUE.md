# Configuration Catalogue

Everything installed, configured, and customized — tracked so it can be reproduced on any machine. Claude should read this file on each machine and implement any unchecked items.

## Theme: Tokyo Night (unified across all tools)

| Tool | Config File | Details |
|------|-------------|---------|
| Neovim | `init.lua` | `tokyonight.nvim` with josean-dev custom colors, transparent background |
| Windows Terminal | `terminal/windows-terminal-settings.json` | Tokyo Night color scheme + theme, acrylic opacity 90/80 |
| Oh My Posh | `terminal/tokyonight.omp.json` | Tokyo Night prompt theme |
| bat | `terminal/tokyonight_night.tmTheme` | Tokyo Night syntax theme (copy to bat themes dir, run `bat cache --build`) |
| fzf | PS profile `$env:FZF_DEFAULT_OPTS` | Tokyo Night color scheme (inline in profile) |
| GlazeWM | `terminal/glazewm-config.yaml` | Tokyo Night borders (`#7aa2f7` focused, `#565f89` unfocused) |
| Zebar | `terminal/zebar-tokyo-night-bar/` | Tokyo Night bar (workspace indicators, system stats, clock) |
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
- **Starting directory:** `%USERPROFILE%` (patched per machine if needed)
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
- fzf config with fd backend, Tokyo Night color scheme
- **Ctrl+T preview:** smart — uses bat for files, eza tree for directories
- **Alt+C preview:** eza tree for directories
- bat theme set to `tokyonight_night`
- **PSFzf module** — bridges fzf with PSReadLine for shell keybindings:
  - `Ctrl+T` — fuzzy file search (bat/eza preview)
  - `Alt+C` — fuzzy directory jump (eza tree preview)
  - `Ctrl+R` — fuzzy command history search
- Profile location: `$PROFILE` (usually `Documents\PowerShell\Microsoft.PowerShell_profile.ps1`)

## GlazeWM + Zebar (Windows Tiling WM)

### GlazeWM
- **Config:** `terminal/glazewm-config.yaml` -> `~/.glzr/glazewm/config.yaml`
- **Gaps:** 4px inner, 4px outer (36px top for bar)
- **Borders:** Tokyo Night blue (`#7aa2f7`) focused, comment grey (`#565f89`) unfocused
- **Modifier key:** Alt (Win key has OS restrictions)
- **Workspaces:** 9 (Alt+1 through Alt+9)
- **Auto-launches Zebar** on startup, kills on shutdown

### GlazeWM Keybindings
| Keys | Action |
|------|--------|
| `Alt + H/J/K/L` | Focus left/down/up/right (arrows also work) |
| `Alt + 1-9` | Switch to workspace |
| `Alt + A/S` | Previous/next active workspace |
| `Alt + D` | Last used workspace |
| `Alt+Shift + H/J/K/L` | Move window in direction |
| `Alt+Shift + 1-9` | Send window to workspace (and follow) |
| `Alt+Shift + A/D/S/F` | Move workspace to monitor |
| `Alt + U/P` | Shrink/grow width |
| `Alt + I/O` | Shrink/grow height |
| `Alt + R` | Enter resize mode (HJKL, Escape to exit) |
| `Alt + /` | Toggle tiling direction |
| `Alt + F` | Toggle fullscreen |
| `Alt + T` | Toggle tiling |
| `Alt+Shift + Space` | Toggle floating (centered) |
| `Alt + Space` | Cycle focus: tiling -> floating -> fullscreen |
| `Alt + M` | Minimize |
| `Alt+Shift + Q` | Close window |
| `Alt + Enter` | Open Windows Terminal |
| `Alt+Shift + R` | Reload config |
| `Alt+Shift + P` | Pause/unpause GlazeWM |
| `Alt+Shift + E` | Exit GlazeWM |

### Zebar (Status Bar)
- **Widget pack:** `terminal/zebar-tokyo-night-bar/` -> `~/.glzr/zebar/tokyo-night-bar/`
- **Settings:** `terminal/zebar-settings.json` -> `~/.glzr/zebar/settings.json`
- **Height:** 32px, anchored top, spans all monitors
- **Left:** clickable workspace indicators (solid blue highlight on focused)
- **Center:** date and time
- **Right:** tiling direction toggle, CPU %, memory %, battery %
- **Font:** JetBrainsMono Nerd Font + Nerd Font icons via web import

### GlazeWM + Zebar Setup (per machine)
1. `scoop bucket add extras` (if not already)
2. `scoop install extras/glazewm extras/zebar`
3. Copy configs from repo:
   ```bash
   mkdir -p ~/.glzr/glazewm ~/.glzr/zebar/tokyo-night-bar
   cp terminal/glazewm-config.yaml ~/.glzr/glazewm/config.yaml
   cp terminal/zebar-tokyo-night-bar/* ~/.glzr/zebar/tokyo-night-bar/
   cp terminal/zebar-settings.json ~/.glzr/zebar/settings.json
   ```
4. Launch: `glazewm` (Zebar starts automatically)
5. Window rules ignore Zebar so it stays visible across all workspaces

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
| `lazygit` | Git TUI (used by lazygit.nvim plugin) |
| `glazewm` | Tiling window manager (i3-inspired, scoop extras bucket) |
| `zebar` | Status bar for GlazeWM (scoop extras bucket) |

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

## Installer Scripts
| Script | Purpose |
|--------|---------|
| `terminal/install.ps1` | Windows Terminal + Oh My Posh + font + bat theme setup |
| `/setup-nvim` skill | Full Neovim setup (deps, config copy, Mason tools) |

---

## Per-Machine Status

Claude: on each machine, go through every item below. Check the box when confirmed working. If unchecked, implement it. Use `machines.json` for machine-specific paths.

### NBIQ (NBI work laptop — Windows)

#### Scoop Packages
- [x] `neovim`
- [x] `ripgrep`
- [x] `python`
- [x] `ruff`
- [x] `tree-sitter`
- [x] `zig`
- [x] `fzf`
- [x] `fd`
- [x] `eza`
- [x] `zoxide`
- [x] `bat`
- [x] `lazygit`
- [x] `glazewm` (scoop extras)
- [x] `zebar` (scoop extras)

#### Nerd Font
- [x] JetBrainsMono Nerd Font installed (`scoop bucket add nerd-fonts && scoop install nerd-fonts/JetBrainsMono-NF`)

#### PowerShell Modules
- [x] PSFzf installed (`Install-PSResource -Name PSFzf`)

#### Oh My Posh
- [x] Oh My Posh installed (winget)
- [x] Tokyo Night theme copied to `~\.config\oh-my-posh\tokyonight.omp.json`

#### PowerShell Profile
- [x] Full profile deployed to `$PROFILE` (oh-my-posh, zoxide, eza, fzf, bat, PSFzf)
- [x] Ctrl+T fzf file search working (smart preview: bat for files, eza for dirs)
- [x] Alt+C fzf directory jump working
- [x] Ctrl+R fzf history search working
- [x] `ls` aliased to eza
- [x] `cd` aliased to zoxide

#### bat Theme
- [x] `tokyonight_night.tmTheme` installed to bat themes dir
- [x] `bat cache --build` run
- [x] `$env:BAT_THEME` set in profile

#### Windows Terminal
- [x] `settings.json` deployed (Tokyo Night scheme + theme)
- [x] Default profile set to PowerShell 7
- [x] Starting directory set to `%USERPROFILE%`
- [x] JetBrainsMono Nerd Font configured
- [x] Acrylic opacity 90/80
- [x] Windows accent color set to `#7aa2f7` (Manual: Settings > Personalization > Colors)

#### Neovim
- [x] `init.lua` copied to `AppData\Local\nvim\`
- [x] `vim.cmd('cd ...')` set to machine default directory
- [x] `vim.o.shell = 'pwsh'` block present (Windows)
- [x] `vim.g.have_nerd_font = true`
- [x] `<leader>tp` terminal keymap (PowerShell)
- [x] lazy.nvim plugins synced (`Lazy! sync`)
- [x] Mason tools installed (`MasonToolsInstallSync`)
- [x] Treesitter parsers compiled (tree-sitter + zig in PATH)
- [x] Custom plugins in `lua/custom/plugins/` present

#### Verification
- [x] `nvim` opens with Tokyo Night theme
- [x] `ls` shows eza output with icons
- [x] `Ctrl+T` opens fzf with file/dir preview
- [x] `Alt+C` opens fzf directory picker
- [x] `Ctrl+R` opens fzf history
- [x] `<leader>tp` opens PS7 terminal split (run `$PSVersionTable` to confirm)

#### GlazeWM + Zebar
- [x] GlazeWM config deployed (`~/.glzr/glazewm/config.yaml`)
- [x] Zebar Tokyo Night bar deployed (`~/.glzr/zebar/tokyo-night-bar/`)
- [x] Zebar settings deployed (`~/.glzr/zebar/settings.json`)
- [x] GlazeWM launches Zebar on startup
- [x] Zebar ignored in window rules (stays visible across workspaces)
- [x] Workspace switching works (Alt+1-9)
- [x] Bar shows workspaces, date/time, CPU, memory, battery

### SUNDANCE (Home PC — Windows)

#### Scoop Packages
- [x] `neovim`
- [x] `ripgrep`
- [x] `python`
- [x] `ruff`
- [x] `tree-sitter`
- [x] `zig`
- [x] `fzf`
- [x] `fd`
- [x] `eza`
- [x] `zoxide`
- [x] `bat`
- [x] `lazygit` (installed via winget)
- [ ] `glazewm` (scoop extras)
- [ ] `zebar` (scoop extras)

#### Nerd Font
- [x] JetBrainsMono Nerd Font installed

#### PowerShell Modules
- [x] PSFzf installed

#### Oh My Posh
- [x] Oh My Posh installed
- [x] Tokyo Night theme copied to `~\.config\oh-my-posh\tokyonight.omp.json`

#### PowerShell Profile
- [x] Full profile deployed to `$PROFILE`
- [x] Ctrl+T fzf file search working
- [x] Alt+C fzf directory jump working
- [x] Ctrl+R fzf history search working
- [x] `ls` aliased to eza
- [x] `cd` aliased to zoxide

#### bat Theme
- [x] `tokyonight_night.tmTheme` installed to bat themes dir
- [x] `bat cache --build` run
- [x] `$env:BAT_THEME` set in profile

#### Windows Terminal
- [x] `settings.json` deployed
- [x] Default profile set to PowerShell 7
- [x] Starting directory set to `G:\`
- [x] JetBrainsMono Nerd Font configured
- [x] Acrylic opacity 90/80
- [x] Windows accent color set to `#7aa2f7`

#### Neovim
- [x] `init.lua` copied to `AppData\Local\nvim\`
- [x] `vim.cmd('cd ...')` set to machine default directory
- [x] `vim.o.shell = 'pwsh'` block present
- [x] `vim.g.have_nerd_font = true`
- [x] `<leader>tp` terminal keymap
- [x] lazy.nvim plugins synced
- [x] Mason tools installed
- [x] Treesitter parsers compiled
- [x] Custom plugins present

#### Verification
- [x] `nvim` opens with Tokyo Night theme
- [x] `ls` shows eza output with icons
- [x] `Ctrl+T` opens fzf with file/dir preview
- [x] `Alt+C` opens fzf directory picker
- [x] `Ctrl+R` opens fzf history
- [x] `<leader>tp` opens PS7 terminal split

#### GlazeWM + Zebar
- [ ] GlazeWM config deployed (`~/.glzr/glazewm/config.yaml`)
- [ ] Zebar Tokyo Night bar deployed (`~/.glzr/zebar/tokyo-night-bar/`)
- [ ] Zebar settings deployed (`~/.glzr/zebar/settings.json`)
- [ ] GlazeWM launches Zebar on startup
- [ ] Zebar ignored in window rules (stays visible across workspaces)
- [ ] Workspace switching works (Alt+1-9)
- [ ] Bar shows workspaces, date/time, CPU, memory, battery

### linux-lab (Home server — Ubuntu)

#### System Packages (apt)
- [ ] `neovim` (>= 0.11, may need PPA)
- [ ] `ripgrep`
- [ ] `python3`
- [ ] `build-essential`
- [ ] `unzip`

#### CLI Tools
- [ ] `fzf` installed
- [ ] `fd-find` installed
- [ ] `eza` installed
- [ ] `zoxide` installed
- [ ] `bat` installed
- [ ] `lazygit` installed

#### Nerd Font
- [ ] JetBrainsMono Nerd Font installed (if terminal supports it)

#### bat Theme
- [ ] `tokyonight_night.tmTheme` installed to bat themes dir
- [ ] `bat cache --build` run

#### Shell Profile
- [ ] fzf keybindings sourced in `.bashrc`
- [ ] zoxide init in `.bashrc`
- [ ] eza aliases in `.bashrc`
- [ ] bat theme set (`export BAT_THEME="tokyonight_night"`)

#### Neovim
- [ ] `init.lua` copied to `~/.config/nvim/`
- [ ] `vim.cmd('cd ...')` set to machine default directory
- [ ] `vim.o.shell` pwsh block **removed** (Linux)
- [ ] `vim.g.have_nerd_font` set correctly
- [ ] `<leader>tt` terminal keymap (Linux variant)
- [ ] lazy.nvim plugins synced
- [ ] Mason tools installed
- [ ] Treesitter parsers compiled (`build-essential` provides cc)
- [ ] Custom plugins present

#### Verification
- [ ] `nvim` opens with Tokyo Night theme
- [ ] `ls` shows eza output
- [ ] fzf keybindings work (Ctrl+T, Alt+C, Ctrl+R)
- [ ] `<leader>tt` opens terminal split
