# KISS

Keep It Simple — one always-on mode that fuses four reflexes:

- **ponytail** — build the simplest thing that works (YAGNI → stdlib → native → installed dep → one line → minimum).
- **caveman** — say it in the fewest words (terse output, code first, exact technical terms).
- **DRY** — dedupe knowledge on the *third* repeat, never speculatively.
- **Separation of concerns** — one module, one reason to change; split only on dual churn.

When the four conflict, the simplest design that stays correct and secure wins.

## On / off

Auto-on every session. `stop kiss` / `normal mode` / `/kiss off` to disable;
`/kiss` to re-enable. No intensity levels — one mode, the enforced one.

## How it works

Pure prompt injection, no runtime logic on your code:

- `SessionStart` hook (`hooks/kiss-activate.js`) writes the on flag (`~/.claude/.kiss-active`) and injects `skills/kiss/SKILL.md` as context.
- `UserPromptSubmit` hook (`hooks/kiss-tracker.js`) watches for `/kiss` / `/kiss off` and rewrites the flag.

## Install (Claude Code)

```
/plugin marketplace add <path-to-this-dir>
/plugin install kiss
```

Or use just the skill (on-demand, no hooks): copy `skills/kiss/` into `~/.claude/skills/`.
