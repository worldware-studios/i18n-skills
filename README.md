# i18n-skills

Agent skills for i18n workflows — extract hard-coded UI copy, localize, and work with [msg](https://github.com/worldware-studios/msg) / [msg-cli](https://github.com/worldware-studios/msg-cli).

Compatible with Cursor, Claude Code, Codex, VS Code Copilot, and any client that follows the [Agent Skills](https://agentskills.io) standard.

Published as [`@worldware/i18n-skills`](https://www.npmjs.com/package/@worldware/i18n-skills). Skills live at `.agents/skills/` inside the package.

## Install

**From npm:**

```bash
npm install @worldware/i18n-skills
```

Skills are at `node_modules/@worldware/i18n-skills/.agents/skills/`. Copy or symlink them into your project (`.agents/skills/` or `.cursor/skills/`) or your user skill directory.

**From GitHub (skills CLI):**

```bash
npx skills add worldware-studios/i18n-skills
```

**Cursor (GitHub import):** Customize → Skills / Rules → add `https://github.com/worldware-studios/i18n-skills`.

**User-level (clone or copy):**

```bash
# Copy or symlink individual skills
ln -s "$(pwd)/.agents/skills/extract-text" ~/.agents/skills/extract-text

# Cursor also loads ~/.cursor/skills/
ln -s "$(pwd)/.agents/skills/extract-text" ~/.cursor/skills/extract-text
```

**Project-level:**

```bash
cp -R .agents/skills/extract-text /path/to/project/.agents/skills/
# or: /path/to/project/.cursor/skills/
```

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

## Create a new skill

```bash
./scripts/new-skill.sh my-skill-name
```

Then edit `.agents/skills/my-skill-name/SKILL.md` — especially the `description` (what + when).

## Validate

```bash
npm test
# or: ./scripts/validate-skills.sh
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

## Versioning and releases

Pushes to `main` run [semantic-release](https://semantic-release.gitbook.io/). Squash-merge PR titles must follow [Conventional Commits](https://www.conventionalcommits.org) (`type(scope): summary`) so the landed commit can bump the npm version:

- `feat` — minor
- `fix`, `perf` — patch
- `feat!` / `BREAKING CHANGE` — major

`ci`, `chore`, `docs`, `test`, and `refactor` do not publish a new version.

## References

- [Agent Skills specification](https://agentskills.io/specification)
- [Skill creation best practices](https://agentskills.io/skill-creation/best-practices)
- [Cursor skills docs](https://cursor.com/docs/skills)

## License

MIT — see [LICENSE](LICENSE). Individual skills may declare a different `license` in frontmatter.
