---
description: "Backlog refinement — order stories, mark gaps, suggest splits. Triggers on 'backlog review', 'refinement', 'order stories', 'grooming'."
allowed-tools: Read, Glob, Grep, Write, Edit
---

# /backlog

Engage `scrum-master`.

### Steps

1. **Read current backlog**
   - `production/backlog.md` if present
   - Otherwise scan `production/stories/`

2. **Evaluate each story** (3 criteria):

   - **Readiness**: Acceptance criteria present and clear?
     - ❌ → mark: `READINESS_GAP`
   - **Size**: Estimate present? L/XL → split?
     - ❌ Too big → mark: `TOO_BIG`
   - **Freshness**: Older than 90 days?
     - ❌ → mark: `STALE`

3. **Refresh backlog file**

```markdown
# Backlog

> Order: top to bottom = priority

## Ready (sprintable)
- 003 User login — M
- 005 Login screen — S
- 007 Password reset — M

## Needs Refinement
- 010 Notification system — no acceptance criteria ⚠️ READINESS_GAP
- 012 Reporting — XL ⚠️ TOO_BIG → split with /create-stories
- 015 Old messaging — written 100 days ago ⚠️ STALE

## Icebox (future)
- 020 Premium membership
- 022 Mobile app
```

4. Suggest to user:
   - "Detail story 10 with `/analyze`?"
   - "Split story 12 with `/create-stories 012-reporting`?"

### Rules

- Get user approval before reordering
- Never delete a story — move to `Icebox`
