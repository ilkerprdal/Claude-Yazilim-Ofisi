---
description: "Sprint retrospective — what went well, what didn't, what to try, action items. Triggers on 'retro', 'sprint review', 'retrospective'."
allowed-tools: Read, Glob, Grep, Write, Edit, AskUserQuestion
---

# /retro

Engage `scrum-master`.

### Steps

1. Read closed sprint file
2. Calculate velocity:
   - Planned vs completed story count
   - Estimate variance (said M, actually L? note)
3. Ask user 3 questions (in order):
   - **What went well?** Practices / tools / approaches that worked?
   - **What went badly?** Blockers, delays, friction?
   - **What to try?** 1-3 small changes for next sprint

4. Generate action items:
   - Each gets **owner** and **date**
   - Reject vague items ("improve in general") — make concrete

5. Write file:

```markdown
# Retro — Sprint SXX

**Date**: yyyy-mm-dd
**Duration**: X days

## Velocity
- Planned: 5 stories
- Completed: 4
- Variance reason: 1 story blocked on OAuth dependency

## Went Well
- Code review cycle sped up
- ...

## Went Badly
- Architecture decision changed mid-sprint — poor backlog refinement
- ...

## Try Next
- [ ] Backlog refinement every Friday 30 min (owner: scrum-master, by: end of sprint)
- [ ] Architecture decisions resolved pre-sprint (owner: tech-director)
```

6. Write to `production/retros/SXX.md`
7. For next sprint, add learned lessons summary to `.claude/memory/` (if any)
