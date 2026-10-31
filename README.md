# agent-workflow

A small personal workflow for running coding agents in git worktrees inside [herdr](https://herdr.dev).

Main agent stays on `main` and orchestrates. Isolated work gets a worktree that shows up in the herdr sidebar; sub-agents (pi, claude, codex, ...) run in panes of that workspace, so clicking it shows what they are doing. Results come back as files, not terminal scraping.

```
bin/wt                       worktree + sub-agent CLI (bash, needs git, jq, herdr)
skills/wt                    how to use wt
skills/herdr-subagents       protocol and verified pitfalls
hooks/block-agent-tool.sh    blocks the built-in Agent tool
scripts/install.sh           symlinks everything into ~/.local/bin and ~/.claude/skills
scripts/smoke.sh [kind]      end-to-end check (run inside herdr)
AGENT.md / CLAUDE.md         the few rules that cannot be scripted
```

## Use

```bash
scripts/install.sh
wt spawn fix-login impl pi "Fix the login redirect and commit."
wt spawn fix-login review claude "Review git show HEAD."
wt ls
wt rm fix-login --yes
```

Contract: every task is followed by "write `.agent/<role>.md` starting with `STATUS: ok`". `wt spawn` checks that file, retries once, and otherwise prints the pane tail and exits 1. herdr's `done` state is not treated as success.

Set `WT_ROOT` to change where worktrees live (default `~/worktrees`).
