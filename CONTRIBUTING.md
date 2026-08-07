# Contributing

## Add a skill

1. Run `./scripts/new-skill.sh <skill-name>` (or copy `templates/skill/`).
2. Fill in YAML frontmatter:
   - `name` — must match the directory name
   - `description` — third person; include **what** and **when** (trigger terms)
3. Write concise instructions in the `SKILL.md` body.
4. Put long reference material in `references/`, scripts in `scripts/`, static files in `assets/`.
5. Link supporting files one level deep from `SKILL.md` only.
6. Add a row to `CATALOG.md`.
7. Run `./scripts/validate-skills.sh`.

## Description tips

```yaml
# Good
description: Extract text and tables from PDF files, fill forms, merge documents. Use when working with PDFs, forms, or document extraction.

# Poor
description: Helps with PDFs.
```

## Invocation behavior

- Default: the agent may auto-apply the skill when the description matches context.
- Set `disable-model-invocation: true` only when the skill must be invoked explicitly via `/skill-name`.

## Review checklist

- [ ] Name is lowercase letters, numbers, and single hyphens
- [ ] Description is specific and includes trigger terms
- [ ] Body focuses on agent instructions, not marketing copy
- [ ] Optional dirs follow `scripts/`, `references/`, `assets/`
- [ ] Catalog updated
