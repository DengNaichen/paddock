# paddock

A small personal workflow for running coding agents in git worktrees inside [herdr](https://herdr.dev).

Main agent stays on `main` and orchestrates. Isolated work gets a worktree that shows up in the herdr sidebar; sub-agents (pi, claude, codex, ...) run in panes of that workspace, so clicking it shows what they are doing. Results come back as files, not terminal scraping.

```
.claude-plugin/              plugin.json, marketplace.json
bin/wt                       worktree + sub-agent CLI (on PATH when the plugin is enabled; needs git, jq, herdr)
skills/wt                    how to use wt
skills/herdr-subagents       protocol and verified pitfalls
hooks/                       inside herdr, blocks the built-in Agent tool (no effect outside herdr)
scripts/smoke.sh [kind]      end-to-end check (run inside herdr)
AGENT.md / CLAUDE.md         contributor notes; CLAUDE.md just imports AGENT.md
```

## Install

```
/plugin marketplace add DengNaichen/paddock
/plugin install paddock@paddock
```

Requires Claude Code 2.1.91+ (plugin `bin/`).

## Use

```bash
wt spawn fix-login impl pi "Fix the login redirect and commit."
wt spawn fix-login review claude "Review git show HEAD."
wt ls
wt rm fix-login --yes
```

Contract: every task is followed by "write `.agent/<role>.md` starting with `STATUS: ok`". `wt spawn` checks that file, retries once, and otherwise prints the pane tail and exits 1. herdr's `done` state is not treated as success.

Set `WT_ROOT` to change where worktrees live (default `~/worktrees`).
