# Terminal config installer - Tokyo Night theme
# Run from the terminal/ directory: pwsh -File install.ps1

param(
    [switch]$SkipOhMyPosh
)

$ErrorActionPreference = "Stop"
$ScriptDir = $PSScriptRoot

Write-Host "=== Terminal Config Installer ===" -ForegroundColor Blue

# 1. Install Oh My Posh
if (-not $SkipOhMyPosh) {
    if (Get-Command oh-my-posh -ErrorAction SilentlyContinue) {
        Write-Host "[ok] Oh My Posh already installed ($(oh-my-posh version))" -ForegroundColor Green
    } else {
        Write-Host "[..] Installing Oh My Posh via winget..." -ForegroundColor Yellow
        winget install JanDeDobbeleer.OhMyPosh -s winget --accept-source-agreements --accept-package-agreements
        Write-Host "[ok] Oh My Posh installed" -ForegroundColor Green
    }
}

# 2. Install JetBrainsMono Nerd Font (if not present)
$FontCheck = [System.Drawing.Text.InstalledFontCollection]::new().Families |
    Where-Object { $_.Name -match "JetBrainsMono Nerd" }
if ($FontCheck) {
    Write-Host "[ok] JetBrainsMono Nerd Font already installed" -ForegroundColor Green
} else {
    Write-Host "[..] Installing JetBrainsMono Nerd Font via Oh My Posh..." -ForegroundColor Yellow
    oh-my-posh font install JetBrainsMono
    Write-Host "[ok] JetBrainsMono Nerd Font installed" -ForegroundColor Green
}

# 3. Copy Oh My Posh theme config
$OmpDest = "$env:USERPROFILE\.config\oh-my-posh"
if (-not (Test-Path $OmpDest)) { New-Item -ItemType Directory -Path $OmpDest -Force | Out-Null }
Copy-Item "$ScriptDir\tokyonight.omp.json" "$OmpDest\tokyonight.omp.json" -Force
Write-Host "[ok] Oh My Posh config -> $OmpDest\tokyonight.omp.json" -ForegroundColor Green

# 4. Update PowerShell profile
$ProfileDir = Split-Path $PROFILE
if (-not (Test-Path $ProfileDir)) { New-Item -ItemType Directory -Path $ProfileDir -Force | Out-Null }

$OmpInitLine = 'oh-my-posh init pwsh --config "$env:USERPROFILE\.config\oh-my-posh\tokyonight.omp.json" | Invoke-Expression'

if (Test-Path $PROFILE) {
    $Content = Get-Content $PROFILE -Raw
    if ($Content -match "oh-my-posh init") {
        Write-Host "[ok] PowerShell profile already has Oh My Posh init" -ForegroundColor Green
    } else {
        # Prepend the Oh My Posh init line
        $NewContent = "# Oh My Posh - Tokyo Night prompt`n$OmpInitLine`n`n$Content"
        Set-Content -Path $PROFILE -Value $NewContent -NoNewline
        Write-Host "[ok] Added Oh My Posh init to $PROFILE" -ForegroundColor Green
    }
} else {
    Copy-Item "$ScriptDir\Microsoft.PowerShell_profile.ps1" $PROFILE -Force
    Write-Host "[ok] Created PowerShell profile at $PROFILE" -ForegroundColor Green
}

# 5. Copy Windows Terminal settings
$WtPaths = @(
    "$env:LOCALAPPDATA\Packages\Microsoft.WindowsTerminal_8wekyb3d8bbwe\LocalState",
    "$env:LOCALAPPDATA\Microsoft\Windows Terminal"
)
$WtInstalled = $false
foreach ($WtPath in $WtPaths) {
    if (Test-Path $WtPath) {
        $Dest = "$WtPath\settings.json"
        if (Test-Path $Dest) {
            $Backup = "$Dest.backup"
            Copy-Item $Dest $Backup -Force
            Write-Host "[ok] Backed up existing settings -> $Backup" -ForegroundColor Yellow
        }
        Copy-Item "$ScriptDir\windows-terminal-settings.json" $Dest -Force
        Write-Host "[ok] Windows Terminal settings -> $Dest" -ForegroundColor Green
        $WtInstalled = $true
        break
    }
}
if (-not $WtInstalled) {
    Write-Host "[!!] Windows Terminal not found - copy windows-terminal-settings.json manually" -ForegroundColor Red
}

Write-Host ""
Write-Host "Done! Restart Windows Terminal to see changes." -ForegroundColor Blue
