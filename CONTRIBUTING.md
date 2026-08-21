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
7. Run `npm test` (or `./scripts/validate-skills.sh`).

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

## Pull requests

PRs are squash-merged to `main`. **Title the PR using [Conventional Commits](https://www.conventionalcommits.org)** (`type(scope): summary`). That title becomes the landed commit and is what [semantic-release](https://semantic-release.gitbook.io/) uses to version `@worldware/i18n-skills`.

Allowed types: `feat`, `fix`, `refactor`, `test`, `docs`, `build`, `chore`, `perf`, `ci`.

- `feat` — minor version
- `fix`, `perf` — patch version
- A `BREAKING CHANGE:` footer in the PR body — major version
- `ci`, `chore`, `docs`, `test`, `refactor`, `build` — no npm release

Do not edit `package.json` `version`. Leave it at `0.0.0`; semantic-release sets the published version.

## Releases

Pushes to `main` run the Verify and Release workflow. After tests pass, semantic-release publishes `@worldware/i18n-skills` to npm via [trusted publishing](https://docs.npmjs.com/trusted-publishers/) (OIDC; no `NPM_TOKEN`).

The package enables [npm provenance](https://docs.npmjs.com/generating-provenance-statements). Provenance is only accepted from a **public** GitHub repository. A private repo will fail `npm publish` with `E422` even when OIDC authentication succeeds.

## Review checklist

- [ ] Name is lowercase letters, numbers, and single hyphens
- [ ] Description is specific and includes trigger terms
- [ ] Body focuses on agent instructions, not marketing copy
- [ ] Optional dirs follow `scripts/`, `references/`, `assets/`
- [ ] Catalog updated
- [ ] PR title follows Conventional Commits
- [ ] `package.json` version left at `0.0.0`
