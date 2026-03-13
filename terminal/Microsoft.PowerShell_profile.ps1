# Oh My Posh - Tokyo Night prompt
oh-my-posh init pwsh --config "$env:USERPROFILE\.config\oh-my-posh\tokyonight.omp.json" | Invoke-Expression

# --- zoxide (smarter cd) ---
Invoke-Expression (& { (zoxide init powershell | Out-String) })
Set-Alias -Name cd -Value z -Option AllScope -Scope Global -Force

# --- eza (better ls) ---
Remove-Alias -Name ls -Force -Scope Global -ErrorAction SilentlyContinue
function ls { eza --color=always --long --git --icons=always --no-time --no-user --no-permissions -a --group-directories-first @args }
function lt { eza --color=always --tree --icons=always --git -a --group-directories-first -L 2 @args }

# --- bat ---
$env:BAT_THEME = "tokyonight_night"

# --- fzf ---
# Color scheme (Tokyo Night)
$env:FZF_DEFAULT_OPTS = "--color=fg:#c0caf5,bg:#1a1b26,hl:#bb9af7,fg+:#c0caf5,bg+:#292e42,hl+:#bb9af7,info:#7aa2f7,prompt:#7dcfff,pointer:#7aa2f7,marker:#9ece6a,spinner:#9ece6a,header:#565f89,border:#27a1b9"

# Use fd instead of default find
$env:FZF_DEFAULT_COMMAND = "fd --hidden --strip-cwd-prefix --exclude .git"
$env:FZF_CTRL_T_COMMAND = "fd --hidden --strip-cwd-prefix --exclude .git"
$env:FZF_ALT_C_COMMAND = "fd --type=d --hidden --strip-cwd-prefix --exclude .git"

# Preview: bat for files (Ctrl+T), eza tree for dirs (Alt+C)
$env:FZF_CTRL_T_OPTS = '--preview "if exist {}\\* (eza --tree --color=always --icons=always -L 2 {}) else (bat -n --color=always --line-range :500 {})"'
$env:FZF_ALT_C_OPTS = '--preview "eza --tree --color=always {}"'

# Register fzf keybindings in PSReadLine (Ctrl+T, Alt+C, Ctrl+R)
Import-Module PSFzf
Set-PsFzfOption -PSReadlineChordProvider 'Ctrl+t' -PSReadlineChordReverseHistory 'Ctrl+r' -PSReadlineChordSetLocation 'Alt+c'
