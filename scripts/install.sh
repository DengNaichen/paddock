#!/usr/bin/env bash
# Symlink wt and skills, ignore .agent/ globally. Does not edit settings.json.
set -euo pipefail
here=$(cd "$(dirname "$0")/.." && pwd)
mkdir -p ~/.local/bin ~/.claude/skills ~/.config/git
ln -sfn "$here/bin/wt" ~/.local/bin/wt
for s in "$here"/skills/*/; do ln -sfn "${s%/}" ~/.claude/skills/"$(basename "$s")"; done
grep -qxF '.agent/' ~/.config/git/ignore 2>/dev/null || echo '.agent/' >> ~/.config/git/ignore
cat <<EOM
Installed. To block the built-in Agent tool, add to ~/.claude/settings.json:
  "hooks": {"PreToolUse": [{"matcher": "Agent", "hooks": [{"type": "command", "command": "$here/hooks/block-agent-tool.sh"}]}]}
EOM
