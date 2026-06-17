# KISS — statusline badge for Claude Code. Mirrors caveman-statusline.ps1:
# reads the on/off flag, validates it, renders a colored [CAVEMAN-KISS] when on.
#
# Usage in ~/.claude/settings.json:
#   "statusLine": { "type": "command", "command": "powershell -ExecutionPolicy Bypass -File \"...\\kiss-statusline.ps1\"" }

$ClaudeDir = if ($env:CLAUDE_CONFIG_DIR) { $env:CLAUDE_CONFIG_DIR } else { Join-Path $HOME ".claude" }
$Flag = Join-Path $ClaudeDir ".kiss-active"
if (-not (Test-Path -LiteralPath $Flag)) { exit 0 }

# Refuse reparse points (symlink/junction) and oversized files — stops a local
# attacker pointing the flag at a secret and rendering its bytes to the terminal.
try {
    $Item = Get-Item -LiteralPath $Flag -Force -ErrorAction Stop
    if ($Item.Attributes -band [System.IO.FileAttributes]::ReparsePoint) { exit 0 }
    if ($Item.Length -gt 64) { exit 0 }
} catch { exit 0 }

$State = ""
try {
    $Raw = Get-Content -LiteralPath $Flag -TotalCount 1 -ErrorAction Stop
    if ($null -ne $Raw) { $State = ([string]$Raw).Trim() }
} catch { exit 0 }

# Sanitize to [a-z0-9-] then whitelist — blocks terminal-escape / OSC injection.
$State = $State.ToLowerInvariant() -replace '[^a-z0-9-]', ''
if ($State -ne "on") { exit 0 }

$Esc = [char]27
[Console]::Write("${Esc}[38;5;81m[CAVEMAN-KISS]${Esc}[0m")
