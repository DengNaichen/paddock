# Agent rules

Run inside [herdr](https://herdr.dev) (`HERDR_ENV=1`). Main agent stays on the main checkout and orchestrates; isolated or parallel work goes to a worktree via `wt`.

- Default is to do the work yourself. Spawn only for: an isolated worktree, independent parallel work, an independent review by a different model, or a context that is bloating. Sequential work, same-file edits and small tasks stay in the main loop. Keep role types to a handful.
- Sub-agents are started with `wt spawn`, never with the built-in Agent tool (a hook blocks it).
- Judge sub-agent success by the artifact `.agent/<role>.md` (`STATUS: ok`), never by herdr `done`.
- Never delete a worktree without the user's confirmation (`wt rm` previews unless `--yes`).
- Mechanical rules live in `bin/wt` and `hooks/`, not here. Add a check there before adding a sentence here.

See `skills/wt` and `skills/herdr-subagents`.
