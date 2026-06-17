# caveman-kiss

**KISS** = *Keep It Simple, Stupid* — the old engineering maxim that a system
works best when it's kept simple rather than made complicated.

Lazy senior dev mode for Claude Code: the simplest code that works, said in the
fewest words. Always on, with a `[CAVEMAN-KISS]` statusline badge.

It keeps four habits firing on every response:

- **Simplest thing that works** — does it need to exist (YAGNI)? → standard library / built-ins → native feature → installed dep → one line → minimum code.
- **Written once** — dedupe on the third repeat, never speculatively. A wrong abstraction costs more than duplication.
- **Clean seams** — one module, one reason to change. Split only when concerns genuinely tangle.
- **Fewest words** — code first, terse prose, no dev/prompt dump in user-facing output.

Never simplifies away validation, error handling, security, accessibility, or
tests. When the habits conflict, the simplest design that stays correct and
secure wins.

## Install

```
/plugin marketplace add wmsouza/caveman-kiss
/plugin install kiss
```

## Use

On by default. `/caveman-kiss off` (or "stop kiss" / "normal mode") to pause,
`/caveman-kiss` to resume. One mode — no levels to tune.

For the `[CAVEMAN-KISS]` badge, point your statusline at `hooks/kiss-statusline.ps1`
(Windows) or `hooks/kiss-statusline.sh` in `~/.claude/settings.json`.

## Credits

Built on the ideas of two plugins it shamelessly fuses:

- [ponytail](https://github.com/DietrichGebert/ponytail) by Dietrich Gebert — the lazy-senior-dev / YAGNI build philosophy.
- [caveman](https://github.com/JuliusBrussee/caveman) by Julius Brussee — the terse-output mode and the plugin/hook/badge pattern this borrows.
