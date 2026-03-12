# Oh My Posh - Tokyo Night prompt
oh-my-posh init pwsh --config "$env:USERPROFILE\.config\oh-my-posh\tokyonight.omp.json" | Invoke-Expression

# --- zoxide (smarter cd) ---
Invoke-Expression (& { (zoxide init powershell | Out-String) })
Set-Alias -Name cd -Value z -Option AllScope -Scope Global -Force

# --- eza (better ls) ---
function ls { eza --color=always --long --git --no-filesize --icons=always --no-time --no-user --no-permissions @args }

# --- bat ---
$env:BAT_THEME = "tokyonight_night"

# --- fzf ---
# Color scheme (Josean blue/cyan)
$fg = "#CBE0F0"
$bg = "#011628"
$bg_highlight = "#143652"
$purple = "#B388FF"
$blue = "#06BCE4"
$cyan = "#2CF9ED"

$env:FZF_DEFAULT_OPTS = "--color=fg:${fg},bg:${bg},hl:${purple},fg+:${fg},bg+:${bg_highlight},hl+:${purple},info:${blue},prompt:${cyan},pointer:${cyan},marker:${cyan},spinner:${cyan},header:${cyan}"

# Use fd instead of default find
$env:FZF_DEFAULT_COMMAND = "fd --hidden --strip-cwd-prefix --exclude .git"
$env:FZF_CTRL_T_COMMAND = "fd --hidden --strip-cwd-prefix --exclude .git"
$env:FZF_ALT_C_COMMAND = "fd --type=d --hidden --strip-cwd-prefix --exclude .git"

# Preview: bat for files (Ctrl+T), eza tree for dirs (Alt+C)
$env:FZF_CTRL_T_OPTS = "--preview 'bat -n --color=always --line-range :500 {}'"
$env:FZF_ALT_C_OPTS = "--preview 'eza --tree --color=always {} | head -200'"
