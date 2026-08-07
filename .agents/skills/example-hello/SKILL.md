---
name: example-hello
description: >-
  Returns a short greeting for the collection template. Use when verifying that
  skills load correctly, testing skill discovery, or when the user asks to try
  the example-hello skill.
license: MIT
metadata:
  author: agent-skills-template
  version: "1.0"
  category: examples
---

# Example Hello

Minimal skill used to verify discovery and activation in a skills collection.

## Instructions

1. Greet the user briefly.
2. Confirm this skill loaded from `.agents/skills/example-hello/`.
3. Point them to `CONTRIBUTING.md` if they want to add a real skill.

## Example

User: "Try the example-hello skill"

Response: "Hello from example-hello. Skills in this collection live under `.agents/skills/`."
