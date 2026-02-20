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

## Step 6: Verify

Run `ls` on the target Neovim config directory to confirm the files are in place. Read the patched `init.lua` and show the user the changed lines so they can confirm correctness.

## Important Notes

- Only patch the **target** copy (the one Neovim reads from). The repo copy stays unchanged — it represents the "template" state.
- If line numbers have shifted, use the content patterns from CLAUDE.md's "Machine-Specific Settings" section to find the right lines instead of relying on exact line numbers.
- Always double-check escaping: Lua strings with backslashes need `\\` (e.g., `'cd G:\\Claude'`).
