---
name: herdr-subagents
description: Pitfalls and protocol when running sub-agents through herdr instead of the built-in Agent tool. Read before debugging a sub-agent that "finished" without a result.
---

# Sub-agents through herdr

Separate processes: nothing is returned automatically. The protocol is artifact-based.

| Native Agent tool | herdr equivalent |
|---|---|
| result injected into parent | read `.agent/<role>.md` and the branch commits |
| SendMessage to continue | `herdr agent prompt <name> ...` (same name keeps context) |
| auto wake-up | run `wt spawn` in background |

Verified pitfalls:

1. `agent prompt --wait` returns `done` even when the agent errored (e.g. API 400). Trust the artifact, then `herdr pane read <pane> --source visible` for the error.
2. `claude` asks to trust each new folder. `wt spawn` fails with `agent_not_ready` (agent `blocked`). The user must confirm in the pane; rerunning `wt spawn` reuses the live agent.
3. `pi auth check` can say `ready` while the real run fails. Verify with a real request.
4. Changing agent flags means closing the pane and starting again; there is no in-place switch.
5. `agent start` needs an existing shell pane; `wt` splits one if none is free.
6. Agent names: `[a-z][a-z0-9_-]{0,31}`, unique among live agents.
