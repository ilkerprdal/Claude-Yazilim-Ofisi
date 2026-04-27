---
description: "Create a structured bug report — repro steps, expected vs actual, severity. Triggers on 'there's a bug', 'I found a bug', 'X is broken', 'crash', 'create bug report'."
allowed-tools: Read, Write, Edit, AskUserQuestion
---

# /bug-report

### Template

`production/qa/bugs/NNN-slug.md`:

```markdown
# [NNN] Bug Title

**Severity**: Critical / High / Medium / Low
**Severity Rationale**: Why this severity?
**Where Found**: Dev / Stage / Prod
**Version**: X.Y.Z (or commit hash)

## Summary
One sentence.

## Reproduction Steps
1. ...
2. ...

## Expected Behavior
## Actual Behavior

## Evidence
[Logs, screenshot path, error trace]

## Possible Impact
How many users, which flow

## Suggestion / Notes
[First hypothesis if any]
```

### Rules

- If repro steps missing, **don't write** — ask user first
- Don't assign severity without rationale
