## Summary

- What skill(s) changed and why

**PR title must follow [Conventional Commits](https://www.conventionalcommits.org)** (`type(scope): summary`). The PR is squash-merged, so the title becomes the landed commit and drives the npm version (`feat`/`fix`/`perf` release; `feat!` or `BREAKING CHANGE` is major).

## Checklist

- [ ] `name` matches the skill directory
- [ ] `description` includes what + when (trigger terms)
- [ ] `CATALOG.md` updated (if adding/removing/renaming)
- [ ] `npm test` (or `./scripts/validate-skills.sh`) passes
- [ ] Supporting files are one level deep from `SKILL.md`
- [ ] PR title is Conventional Commits
