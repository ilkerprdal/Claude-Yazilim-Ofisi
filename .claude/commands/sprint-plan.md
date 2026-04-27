---
description: "Plan a new sprint — pick stories from backlog, capacity estimate, create sprint file. Triggers on 'start sprint', 'new sprint plan', 'weekly plan'."
allowed-tools: Read, Glob, Grep, Write, Edit
argument-hint: "[optional: sprint length — 1w | 2w]"
---

# /sprint-plan

Engage `scrum-master`.

### Steps

1. **Gather context**
   - `production/backlog.md` (or list `production/stories/*.md`)
   - Last sprint file in `production/sprints/` (for velocity)
   - Active sprint? Must close first

2. **Capacity estimate**
   - Ask: "Sprint length? (1 week / 2 weeks)"
   - Previous velocity (if any) → target this sprint
   - If no history: "Start small — 3-5 stories"

3. **Story selection**
   - Pick stories with **clear acceptance criteria**
   - Prefer stories without dependencies
   - Mix: 1-2 large + 2-3 medium + 1-2 small
   - Confirm each pick with user

4. **Create sprint file**

```markdown
# Sprint SXX — [yyyy-mm-dd → yyyy-mm-dd]

## Goal
[1-2 sentences — what should be true at the end]

## Stories

| ID | Title | Type | Estimate | Status | Owner |
|----|-------|------|----------|--------|-------|
| 003 | User login | Backend | M | In Progress | backend-developer |

## Sprint Acceptance Criteria
- [ ] All stories `Done`
- [ ] Smoke test passing
- [ ] User accepted

## Risks
- [Known risks]

## Notes
- [Meeting notes]
```

5. Write to `production/sprints/SXX-yyyy-mm-dd.md`
6. Update `active.md` STATUS block
