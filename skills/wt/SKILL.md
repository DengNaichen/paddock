---
name: wt
description: Use inside herdr (HERDR_ENV=1) when work should be isolated or parallelized - create a git worktree, open it in the herdr sidebar, and run sub-agents (pi/claude/codex/...) in it via `wt`.
---

# wt

```bash
wt new   <name> [base]                  # worktree at $WT_ROOT/<repo>/<name> (default ~/worktrees), branch <name>, opens herdr workspace
wt spawn <name> <type> "<task>"         # run a role type in that worktree; agent is <name>-<type>, artifact .agent/<type>.md
wt roles [check]                        # list role types; check sends a real request per type
wt ls                                   # agents, state, pane
wt rm    <name> [--yes]                 # preview, then remove (branch kept)
```

A type in `roles.json` pins the whole runtime: `kind`, `model`, `effort`, extra `args`, `write`, `independent`, optional `preamble`. `~/.config/paddock/roles.json` (or `$PADDOCK_ROLES`) is merged over the defaults; set `"enabled": false` to switch a type off.

Gates enforced by the script, not by prompt:
- `write: false` types fail if the worktree changed (HEAD, status or diff, ignoring `.agent/`).
- `independent: true` types refuse to start when the same kind+model already wrote code in that worktree.
- Every round starts a fresh agent.

- One task = one worktree = one herdr workspace. Several roles (`impl`, `review`) share the workspace as split panes; the user clicks the workspace to watch them.
- `wt spawn` appends the result contract to the task, waits, checks `.agent/<role>.md` starts with `STATUS: ok`, retries once with a fresh agent (original task plus the failed terminal tail), otherwise prints the pane tail and exits 1.
- Run long spawns with Bash `run_in_background` to be woken on completion.
- Optional per-repo setup: an executable `.wt/setup` in the repo runs after the worktree is created.
- Remove only after the user confirms.
