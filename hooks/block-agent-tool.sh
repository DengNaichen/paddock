#!/usr/bin/env bash
# PreToolUse hook (matcher: Agent). Inside herdr, deny the built-in sub-agent tool and point to wt.
# Outside herdr, allow it: this plugin must not change behaviour elsewhere.
[ "${HERDR_ENV:-}" = 1 ] || exit 0
echo "Built-in Agent tool is disabled inside herdr. Use: wt spawn <name> <role> <kind> \"<task>\" (see the wt skill)." >&2
exit 2
