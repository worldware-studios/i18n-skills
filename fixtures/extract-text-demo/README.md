# extract-text demo fixture

Throwaway sample used to dry-run the `extract-text` skill (MsgResource path).

## Layout

| Path | Role |
| ---- | ---- |
| `src/EmptyState.tsx` | Component with i18n lookups |
| `src/i18n/projects/main.js` | MsgProject (`en` → `fr`, `zh`, format `MF1`) |
| `src/i18n/resources/messages.msg.js` | MsgResource with extracted keys |
| `smoke.mjs` | Quick check that the resource formats |

## Re-verify

```bash
cd fixtures/extract-text-demo
node ./smoke.mjs
```
