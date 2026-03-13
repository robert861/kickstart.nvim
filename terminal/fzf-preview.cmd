@echo off
if exist "%~1\*" (
    eza --tree --color=always --icons=always -L 2 "%~1"
) else (
    bat -n --color=always --line-range :500 "%~1"
)
