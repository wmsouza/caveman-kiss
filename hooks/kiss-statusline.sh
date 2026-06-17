#!/usr/bin/env bash
# KISS — statusline badge for Claude Code. Mirrors caveman-statusline.sh:
# reads the on/off flag, validates it, renders a colored [CAVEMAN-KISS] when on.

FLAG="${CLAUDE_CONFIG_DIR:-$HOME/.claude}/.kiss-active"

[ -L "$FLAG" ] && exit 0            # refuse symlinks
[ ! -f "$FLAG" ] && exit 0

# Cap the read at 64 bytes and strip anything outside [a-z0-9-] — blocks
# terminal-escape injection / OSC hyperlink spoofing via the flag contents.
STATE=$(head -c 64 "$FLAG" 2>/dev/null | tr -d '\n\r' | tr '[:upper:]' '[:lower:]')
STATE=$(printf '%s' "$STATE" | tr -cd 'a-z0-9-')

[ "$STATE" = "on" ] || exit 0
printf '\033[38;5;81m[CAVEMAN-KISS]\033[0m'
