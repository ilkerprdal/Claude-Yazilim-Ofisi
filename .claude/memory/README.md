# Memory — Project Learnings

This folder holds project-specific accumulated learnings. Each file is a category.

Managed via `/memory`. Auto-loaded by `CLAUDE.md`.

## Categories (default)

- `technical.md` — library, pattern, architecture preferences
- `avoid.md` — things not to do
- `process.md` — workflow rules
- `domain.md` — domain-specific terms/rules
- `tools.md` — tools/configs used

Empty categories don't need to exist — `/memory add` creates the file.

## Format

Each line is a note with date + source:

```
- [yyyy-mm-dd] Note text — source: ADR-005
- [yyyy-mm-dd] Another note — source: retro-S03
```

## Example

`technical.md`:
```
# Technical Preferences

- [2026-04-26] HTTP client: `httpx` (over requests) — async support — source: ADR-003
- [2026-04-26] Logs in JSON — source: retro-S01
```
