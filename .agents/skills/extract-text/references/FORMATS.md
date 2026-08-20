# Output formats

## YAML

Nested maps; dotted lookup keys map to nesting:

```yaml
projects:
  empty:
    title: No projects yet
```

Lookup: `t('projects.empty.title')`.

- Quote values that look like booleans/numbers or contain `:`.
- Insert under the correct parent; do not flatten existing trees.

## JSON

### Nested key-value (default)

Same structure as YAML, as JSON:

```json
{
  "projects": {
    "empty": {
      "title": "No projects yet"
    }
  }
}
```

### Msg translation JSON

Use only when the project already stores translations this way (e.g. `l10n/translations/<project>/<lang>/<title>.json`):

```json
{
  "title": "Messages",
  "attributes": { "lang": "en", "dir": "ltr" },
  "notes": [],
  "messages": [
    { "key": "projects.empty.title", "value": "No projects yet" }
  ]
}
```

- Append to `messages`; do not drop existing entries.
- Omit per-message `attributes` when they match the resource defaults.
- Keep `title` aligned with the MsgResource it belongs to.

## MsgResource (via `@worldware/msg-cli`)

Source modules for [`@worldware/msg`](https://www.npmjs.com/package/@worldware/msg`). **Create projects and resources with [`@worldware/msg-cli`](https://www.npmjs.com/package/@worldware/msg-cli)** — do not hand-author new project/resource files.

Prefer `npx msg <command>` unless `msg` is already on `PATH` or wired in package scripts.

### Detect init

Init is present when `package.json` has `directories.i18n` and `directories.l10n` and those trees exist (typically `…/projects` and `…/resources` under i18n).

If missing → **prompt the user** to run init before anything else:

```bash
npx msg init
# or custom paths:
npx msg init --i18nDir src/i18n --l10nDir res/l10n
# interactive paths:
npx msg init -i
```

Do not run init until the user confirms (and supplies custom dirs if they want them).

### Create project (when none exist, or user wants a new one)

```bash
npx msg create project <projectName> <source> <targets...> [--format MF1|MF2|NONE]
```

| Prompt for | Example | Notes |
| ---------- | ------- | ----- |
| `projectName` | `Main` | Becomes `i18n/projects/Main.js` |
| source locale | `en` | Required unless `--extend` |
| target locale(s) | `fr` `de` | At least one unless `--extend` |
| format (optional) | `MF2` | Default `MF2` if omitted |

Example after user answers `Main`, `en`, targets `zh` `fr`, format `MF1`:

```bash
npx msg create project Main en zh fr -f MF1
```

To extend an existing project instead: ask for base name and run `npx msg create project <name> --extend <base>` (locales/format optional overrides).

### Create resource (always prompt)

**Always ask** for:

1. **Project name** — which MsgProject to bind (list existing `i18n/projects/*` when available).
2. **Resource title** — becomes `i18n/resources/<title>.msg.js`.

Then:

```bash
npx msg create resource <projectName> <title>
```

If the resource file already exists:

- **Reuse (default for extraction):** skip create; append `.add(...)` to the existing file.
- **Recreate:** only with explicit user OK → `npx msg create resource <projectName> <title> --force`.

### After create: add extracted messages

CLI scaffolds include sample `.add(...)` calls. Replace samples with real entries or append after them:

```js
resource
  .add('projects.empty.title', 'No projects yet')
  .add('projects.empty.body', 'Create your first project to get started.');
```

- Keep keys flat strings (usually dotted).
- Match placeholder syntax to the resolved `format` (`MF1` → `{name}`, `MF2` → `{$name}`, `NONE` → no interpolation).
- Do not change `title`, project import, or `getMessages()` wiring unless asked.

### Lookups in app code

Follow existing UI patterns in the repo, for example:

```ts
import { getMessages } from '#i18n/resources/Messages.msg.js';

const messages = await getMessages();
messages.get('projects.empty.title')?.format();
```

or the project's `MsgMessage` / provider components. Do not introduce `t()` solely for MsgResource projects unless that helper already exists.

### Scaffold checklist

```
MsgResource setup:
- [ ] msg init done (or user approved running it)
- [ ] At least one MsgProject (create via CLI if needed)
- [ ] User confirmed projectName + resource title
- [ ] msg create resource … succeeded (or reuse existing)
- [ ] Extracted strings added via .add(...)
```

## Choosing among formats

| Signal | Format |
| ------ | ------ |
| User names YAML / `.yml` | YAML |
| User names JSON / `.json` | JSON |
| User names MsgResource / `.msg.js` | MsgResource |
| `*.msg.js`, `@worldware/msg`, `i18n/resources` | MsgResource |
| `locales/**/*.json` or i18next-style JSON only | JSON |
| `locales/**/*.{yml,yaml}` only | YAML |
| Mixed or none | Ask the user |
