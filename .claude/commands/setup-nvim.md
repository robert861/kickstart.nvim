---
description: Set up Neovim config on a new machine
allowed-tools: Bash, Read, Write, Edit, Glob, Grep, AskUserQuestion
---

# Setup Neovim Config

You are setting up this Neovim configuration on a new (or current) machine. Follow these steps carefully.

## Step 1: Detect the OS

Check the platform using environment detection (e.g., `uname` or check for Windows paths). Determine whether this is **Windows** or **Linux**.

## Step 2: Gather user preferences

Ask the user two questions:

1. **Default working directory** — the path Neovim should `cd` into on startup (e.g., `G:\Claude` on Windows, `/home/user/projects` on Linux).
2. **Nerd Font** — whether they have a Nerd Font installed and selected in their terminal (`true` or `false`).

## Step 3: Determine the Neovim config path

- **Windows:** `$LOCALAPPDATA\nvim\` (typically `C:\Users\<USERNAME>\AppData\Local\nvim\`)
- **Linux:** `~/.config/nvim/`

Detect the correct path automatically using the platform from Step 1.

## Step 4: Copy repo contents to the Neovim config directory

Copy all files from the repo root to the target Neovim config directory. This ensures the active config matches the repo.

```bash
# Windows (from Git Bash)
cp -r /path/to/repo/* /target/nvim/config/

# Linux
cp -r /path/to/repo/* ~/.config/nvim/
```

## Step 5: Patch init.lua in the target location

Read the **"Machine-Specific Settings"** section in `CLAUDE.md` to identify which lines need patching. Then edit `init.lua` **in the target Neovim config directory** (not the repo copy — the repo stays as the canonical "last deployed" version).

Apply these patches based on the OS and user answers:

### Default directory (line 88)
- **Windows:** `vim.cmd('cd <USER_DIR>')` — backslashes must be double-escaped for Lua (e.g., `G:\\Claude`)
- **Linux:** `vim.cmd('cd <USER_DIR>')` — use forward slashes (e.g., `/home/user/projects`)

### Shell config (lines 91-94)
- **Windows:** Keep the PowerShell block as-is:
  ```lua
  vim.o.shell = 'pwsh'
  vim.o.shellcmdflag = '-NoLogo -NoProfile -ExecutionPolicy RemoteSigned -Command'
  vim.o.shellquote = ''
  vim.o.shellxquote = ''
  ```
- **Linux:** Remove the entire PowerShell block (lines 91-94). Linux uses its default shell.

### Nerd Font flag (line 104)
- Set `vim.g.have_nerd_font` to `true` or `false` based on the user's answer.

### Terminal keymap (line 211)
- **Windows:** Keep as-is: `vim.cmd 'vsplit | terminal pwsh'` with desc `'[T]erminal [P]owershell split'`
- **Linux:** Change to: `vim.cmd 'vsplit | terminal'` with desc `'[T]erminal split'` and update the keymap from `<leader>tp` to `<leader>tt`

## Step 6: Restore memory file

The repo contains a memory file at `.claude/memory/MEMORY.md` with accumulated setup notes. Copy it to the Claude Code memory location so it's available in this session:

```bash
# Determine the project memory path (Claude Code uses a hash of the working directory)
# The memory dir is: ~/.claude/projects/<hash>/memory/
# The hash replaces path separators with dashes. Examples:
#   Windows: C:\Users\Robert.Bailey\Documents\SKUNKWORKS\kickstart.nvim
#          → C--Users-Robert.Bailey-Documents-SKUNKWORKS-kickstart-nvim
#   Linux:   /home/user/projects/kickstart.nvim
#          → -home-user-projects-kickstart.nvim

# Compute the hash from the current working directory and copy:
PROJ_HASH=$(pwd | sed 's|[/\\]|-|g' | sed 's|^-||' | sed 's|:||g')
MEMORY_DIR="$HOME/.claude/projects/$PROJ_HASH/memory"
mkdir -p "$MEMORY_DIR"
cp .claude/memory/MEMORY.md "$MEMORY_DIR/MEMORY.md"
echo "Memory restored to $MEMORY_DIR"
```

## Step 7: Install dependencies (Windows only)

On Windows, install required tools via scoop before first launch:

```bash
# Install scoop if not present
powershell -Command "Set-ExecutionPolicy RemoteSigned -Scope CurrentUser -Force; irm get.scoop.sh | iex"

# Core tools
scoop install neovim ripgrep python

# Treesitter compiler (REQUIRED on Windows — tree-sitter build uses zig as C compiler)
scoop install tree-sitter zig

# Nerd Font
scoop bucket add nerd-fonts && scoop install nerd-fonts/JetBrainsMono-NF

# Formatters/linters (Mason needs these in PATH for some installs)
scoop install ruff
```

Then install plugins:
```bash
nvim --headless "+Lazy! sync" +qa
nvim --headless -c "lua vim.defer_fn(function() vim.cmd('MasonToolsInstallSync') end, 2000)" -c "sleep 30" +qa
```

## Step 8: Windows Terminal background colour

Add to `profiles.defaults` in Windows Terminal `settings.json`
(`C:\Users\<user>\AppData\Local\Packages\Microsoft.WindowsTerminal_8wekyb3d8bbwe\LocalState\settings.json`):

```json
"defaults":
{
    "background": "#1d2021",
    "font":
    {
        "face": "JetBrainsMono NF"
    }
},
```

`#1d2021` matches gruvbox-material `hard` dark background.

## Step 9: Verify

Run `ls` on the target Neovim config directory to confirm the files are in place. Read the patched `init.lua` and show the user the changed lines so they can confirm correctness.

## Important Notes

- Only patch the **target** copy (the one Neovim reads from). The repo copy stays unchanged — it represents the "template" state.
- If line numbers have shifted, use the content patterns from CLAUDE.md's "Machine-Specific Settings" section to find the right lines instead of relying on exact line numbers.
- Always double-check escaping: Lua strings with backslashes need `\\` (e.g., `'cd G:\\Claude'`).
