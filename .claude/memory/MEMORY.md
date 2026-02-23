# Kickstart.nvim Project Memory

## Windows Setup (new machine checklist)

Run `/setup-nvim` skill. It handles everything. Key steps:
1. Install scoop (user-level, no admin): `powershell -Command "Set-ExecutionPolicy RemoteSigned -Scope CurrentUser -Force; irm get.scoop.sh | iex"`
2. `scoop install neovim ripgrep python ruff` + `scoop bucket add nerd-fonts && scoop install nerd-fonts/JetBrainsMono-NF`
3. Copy repo → `C:\Users\<user>\AppData\Local\nvim\`
4. Patch `init.lua` line 88 (default dir), line 104 (nerd font flag)
5. Install tree-sitter deps (see below)
6. Run `nvim --headless "+Lazy! sync" +qa` then `MasonToolsInstallSync`

## Known Issue: Treesitter compile error on Windows

**Symptom:** Parsers fail to compile / `tree-sitter` not found in PATH.

**Root cause:** `nvim-treesitter` (v1, Neovim 0.11+) uses `tree-sitter-cli` (not `cc`/`gcc`) to compile parsers. `tree-sitter build` uses `zig` as its C compiler on Windows.

**Fix:** Install both via scoop:
```
scoop install tree-sitter zig
```

Scoop shims go into `C:\Users\<user>\scoop\shims` which is in the Windows user PATH — takes effect in any new terminal. No config changes to `init.lua` needed.

**Verify:** Open a new terminal and run `tree-sitter --version` and `zig version` from PowerShell.

## Mason LSP installs

Installed via `MasonToolsInstallSync`. `ruff` needs Python — install `scoop install python` first. All others work without Python.

**Installed:** lua-language-server, pyright, typescript-language-server, bash-language-server, json-lsp, stylua, prettierd

## Windows Terminal settings.json

File: `C:\Users\<user>\AppData\Local\Packages\Microsoft.WindowsTerminal_8wekyb3d8bbwe\LocalState\settings.json`

Add to `profiles.defaults` to match nvim gruvbox-material hard background and set Nerd Font:
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

`#1d2021` = gruvbox-material `hard` dark `bg0`.

## Machine-specific init.lua lines (per CLAUDE.md)

| Line | Setting |
|------|---------|
| 88 | `vim.cmd('cd <dir>')` — patch per machine |
| 91-94 | PowerShell block — keep on Windows, remove on Linux |
| 104 | `vim.g.have_nerd_font` — true/false |
| 211 | Terminal keymap — `<leader>tp` pwsh on Windows, `<leader>tt` on Linux |
