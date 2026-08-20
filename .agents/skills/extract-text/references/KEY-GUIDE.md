# Key guide

## Naming

- Prefer `domain.uiElement.role` — e.g. `checkout.payment.submit`, `nav.sidebar.home`.
- Use lowercase segments separated by dots in source lookups; nest the same structure in YAML/JSON. For MsgResource, keep the dotted string as the `.add` key.
- Avoid keys that include punctuation from the copy (`are_you_sure`, `click_here`).
- Prefer semantic roles (`title`, `subtitle`, `cta`, `error`, `placeholder`) over ordinals (`text1`, `label2`).

## What counts as user-facing

| Extract | Usually skip |
| ------- | ------------ |
| Visible labels, headings, body copy | `console.*`, logger messages |
| Button / link text | Import/module paths |
| `placeholder`, `title`, `aria-*`, `alt` | `data-testid`, analytics event names |
| User-visible validation messages | HTTP headers, content types |
| Empty / error / success state copy | Feature flags, env keys |

## Plurals and variants

If the project has a plural scheme, follow it (e.g. `key.one` / `key.other`). Otherwise extract the singular string and leave a short note that plural rules were not defined.

## Merging locale files

- **YAML / nested JSON:** Insert under the correct parent node; do not flatten nested trees that already exist. Quote YAML values that look like booleans/numbers (`"true"`, `"10"`) or contain `:`.
- **Msg translation JSON:** Append `{ key, value }` objects to `messages`; preserve `title` / `attributes` / existing entries.
- **MsgResource:** Create via `msg create resource` (see [FORMATS.md](FORMATS.md)); then append `.add(...)`. Do not hand-write new resource/project files or rewrite the `MsgResource.create` header unless required.
- Keep a single source locale (usually `en`) as the extraction target unless asked otherwise.
- Format details: [FORMATS.md](FORMATS.md).

## Conflicts

- Same key, different copy → choose a more specific key; do not overwrite silently.
- Same copy, different meaning → separate keys (e.g. `common.cancel` vs `checkout.cancelOrder`).
