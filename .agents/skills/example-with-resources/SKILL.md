---
name: example-with-resources
description: >-
  Demonstrates scripts, references, and assets in an Agent Skill. Use when
  learning the collection template layout, scaffolding a skill with optional
  directories, or when the user mentions progressive disclosure or skill resources.
license: MIT
metadata:
  author: agent-skills-template
  version: "1.0"
  category: examples
---

# Example With Resources

Shows how to keep `SKILL.md` short and load details on demand.

## Instructions

1. Read this file first; do not load optional files until needed.
2. To print a sample greeting, run: `scripts/greet.sh <name>`
3. For deeper layout notes, read [references/REFERENCE.md](references/REFERENCE.md).
4. For a copy-paste starter body, use [assets/skill-body-stub.md](assets/skill-body-stub.md).

## When to expand context

| Need | Load |
| ---- | ---- |
| Run a helper | `scripts/greet.sh` |
| Understand optional dirs | `references/REFERENCE.md` |
| Draft a new skill body | `assets/skill-body-stub.md` |
