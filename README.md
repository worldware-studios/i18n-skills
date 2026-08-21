# Agent Skills Collection Template

A GitHub-ready template for collecting, sharing, and versioning [Agent Skills](https://agentskills.io) — portable packages that teach AI agents specialized workflows.

Compatible with Cursor, Claude Code, Codex, VS Code Copilot, and any client that follows the Agent Skills standard.

## Layout

```text
.
├── .agents/skills/          # Skills discovered by agents (portable path)
│   └── extract-text/        # Externalize hard-coded TS/JS strings for i18n
│       ├── SKILL.md
│       └── references/      # Optional on-demand docs
├── fixtures/                # Dry-run / demo projects for skills
├── templates/skill/         # Copy this when adding a new skill
├── scripts/                 # Collection-level tooling
├── CATALOG.md               # Human-readable skill index
└── CONTRIBUTING.md          # How to add or change skills
```

Each skill is a directory whose name matches the `name` field in `SKILL.md`.

## Quick start

### Use this as a template

1. Click **Use this template** on GitHub (or clone this repo).
2. Rename the collection in `README.md` and `CATALOG.md`.
3. Add your skills under `.agents/skills/`.
4. Update `CATALOG.md` and run `./scripts/validate-skills.sh`.

### Install skills locally

**User-level (all projects):**

```bash
# Copy or symlink individual skills
ln -s "$(pwd)/.agents/skills/my-skill" ~/.agents/skills/my-skill

# Cursor also loads ~/.cursor/skills/
ln -s "$(pwd)/.agents/skills/my-skill" ~/.cursor/skills/my-skill
```

**Project-level (one repo):**

```bash
cp -R .agents/skills/my-skill /path/to/project/.agents/skills/
# or: /path/to/project/.cursor/skills/
```

**Cursor (GitHub import):** Customize → Skills / Rules → add the repository URL.

### Create a new skill

```bash
./scripts/new-skill.sh my-skill-name
```

Then edit `.agents/skills/my-skill-name/SKILL.md` — especially the `description` (what + when).

### Validate

```bash
./scripts/validate-skills.sh
```

Requires [`skills-ref`](https://github.com/agentskills/agentskills/tree/main/skills-ref) when you want full frontmatter validation:

```bash
npm install -g @agentskills/skills-ref   # if published
# or clone agentskills and run skills-ref validate
```

## Skill checklist

- [ ] Folder name matches `name` in frontmatter (lowercase, hyphens)
- [ ] `description` includes **what** the skill does and **when** to use it
- [ ] `SKILL.md` stays concise (under ~500 lines); details go in `references/`
- [ ] Scripts are self-contained and documented
- [ ] Entry added to `CATALOG.md`

## References

- [Agent Skills specification](https://agentskills.io/specification)
- [Skill creation best practices](https://agentskills.io/skill-creation/best-practices)
- [Cursor skills docs](https://cursor.com/docs/skills)

## License

MIT — see [LICENSE](LICENSE). Individual skills may declare a different `license` in frontmatter.
