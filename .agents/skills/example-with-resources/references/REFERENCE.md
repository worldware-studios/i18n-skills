# Reference: skill resource layout

Optional directories recommended by the [Agent Skills specification](https://agentskills.io/specification):

| Directory | Purpose |
| --------- | ------- |
| `scripts/` | Executables the agent may run |
| `references/` | Docs loaded only when needed |
| `assets/` | Templates, images, data files |

## Progressive disclosure

1. **Metadata** — `name` + `description` (~100 tokens), always available for discovery
2. **Instructions** — full `SKILL.md` body when activated
3. **Resources** — scripts / references / assets only when the task needs them

Keep references focused. Prefer several small files over one large dump.
