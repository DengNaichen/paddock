#!/usr/bin/env bash
# PreToolUse hook (matcher: Agent): deny the built-in sub-agent tool, point to wt spawn.
echo "Built-in Agent tool is disabled. Use: wt spawn <name> <role> <kind> \"<task>\"  (see skills/wt)" >&2
exit 2
