# Agent rules

Run inside [herdr](https://herdr.dev) (`HERDR_ENV=1`). Main agent stays on the main checkout and orchestrates; isolated or parallel work goes to a worktree via `wt`.

- Sub-agents are started with `wt spawn`, never with the built-in Agent tool (a hook blocks it).
- Judge sub-agent success by the artifact `.agent/<role>.md` (`STATUS: ok`), never by herdr `done`.
- Never delete a worktree without the user's confirmation (`wt rm` previews unless `--yes`).
- Mechanical rules live in `bin/wt` and `hooks/`, not here. Add a check there before adding a sentence here.

See `skills/wt` and `skills/herdr-subagents`.
