---
description: "View or add project-specific learnings. Loaded each session, agents stay consistent. Triggers on 'memory', 'lessons learned', 'project notes', 'remember this'."
allowed-tools: Read, Glob, Grep, Write, Edit, AskUserQuestion
argument-hint: "[optional: 'show' | 'add' | 'cleanup']"
---

# /memory

Project-specific learnings under `.claude/memory/`. Loaded automatically by
`CLAUDE.md` each session → agents behave consistently.

### Modes

#### `/memory show` (default)
List all current learnings by category:

```
## Technical Preferences
- HTTP client: `httpx` (over requests) — async support
- Logs in JSON format — easier analysis

## Avoid
- Direct SQL — always use ORM
- Don't read settings from os.environ — use config class

## Process
- PRs under 200 lines
- Every bug fix gets a regression test
```

#### `/memory add [category] [note]`
Add a new learning to `.claude/memory/[category].md`.

Categories:
- `technical` — library, pattern, architecture preferences
- `avoid` — things not to do
- `process` — workflow rules
- `domain` — domain-specific terms/rules
- `tools` — tools/configs used

#### `/memory cleanup`
Review old/outdated notes with the user.

### Auto-Trigger

Suggest this without user asking:
- After retro highlights something positive → `/memory add process`
- After ADR written → `/memory add technical` with summary
- After repeated bug observed → `/memory add avoid`

### Format

`.claude/memory/[category].md` files:

```markdown
# [Category Name]

- [yyyy-mm-dd] [Note] — [source: ADR-005 / retro-S03 / etc]
- [yyyy-mm-dd] [Note] — [source]
```

Loaded via `@.claude/memory/technical.md` etc. from CLAUDE.md.

### Output

```
STATUS: COMPLETED
ACTION: SHOW | ADD | CLEANUP
CATEGORY: [if any]
ADDED: [new notes]
TOTAL_NOTE_COUNT: [total notes in memory]
```
