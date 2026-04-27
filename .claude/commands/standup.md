---
description: "Daily standup — active sprint story status, blockers, today's risks. Triggers on 'standup', 'how's it going', 'daily report', 'where were we'."
allowed-tools: Read, Glob, Grep, Write, Edit
---

# /standup

Engage `scrum-master`.

### Steps

1. Find the active sprint file (most recent in `production/sprints/`)
2. For each story in the sprint, **read its file status** (`production/stories/`)
3. Summarize:

```
SPRINT: SXX (day X / Y)
PROGRESS: [completed]/[total] stories

IN PROGRESS:
- 003 User login (backend-developer, started yesterday)
- 005 Login screen (frontend-developer, 50%)

IN REVIEW:
- 002 Password rules (awaiting code-review)

BLOCKED:
- 007 OAuth — auth provider not chosen (owner: product-manager)

TODAY'S RISKS:
- 005 may slip to next sprint (UX not yet approved)

DONE:
- 001, 004
```

4. Append to `production/standup-log.md` with date heading

### Rules

- Read from story file `Status:` field, don't assume
- Show blockers clearly — who solves, what's needed
- Surface risks early
