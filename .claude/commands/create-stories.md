---
description: "Break architecture into implementable stories — each independent, testable, with clear acceptance criteria. Triggers on 'create stories', 'extract tasks', 'sprint backlog', 'user story', 'hikaye olustur'."
allowed-tools: Read, Glob, Write, Edit
---

# /create-stories

Input: `docs/architecture/architecture.md` + `docs/product/concept.md`.
Output: `production/stories/NNN-slug.md` files.

### Story Template

```markdown
# [NNN] Story Title

**Type**: Backend / Frontend / Full-stack / Config
**Estimate**: XS / S / M / L

## Goal
One sentence — what does this story enable?

## Acceptance Criteria
- [ ] User can do X
- [ ] When Y, then Z
- [ ] Error cases: ...

## Technical Notes
- Related ADR: ...
- Files to touch: ...
- Dependency: (other story)

## Test Evidence
- Logic test / integration test / manual walkthrough

## Status
Draft / Ready / In Progress / Review / Done
```

### Flow

1. `product-manager` proposes story list (title + goal)
2. User approval → separate file per story
3. Dependencies clearly stated per story
4. Suggested story order provided

For very large stories, ask "split into smaller pieces?"
