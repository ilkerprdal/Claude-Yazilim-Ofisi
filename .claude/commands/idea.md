---
description: "Turn a project or feature idea into a structured concept document. Triggers on 'I want to build X', 'develop an idea', 'concept for X', 'fikir', 'yeni proje fikri'."
allowed-tools: Read, Write, Edit, AskUserQuestion
---

# /idea

Guided idea development. Engage `product-manager`.

### Flow

1. **Problem**: What problem are we solving? Who is affected?
2. **User**: Who will use it? What do they use today?
3. **Value proposition**: How is it different from alternatives?
4. **Scope**: What's the minimum for MVP? What's explicitly out?
5. **Success criteria**: How will we measure?

For each section, generate 2-3 options, get user choice/correction.

### Output

Write to `docs/product/concept.md`:

```markdown
# [Project Name]

## Problem
## Target User
## Value Proposition
## MVP Scope (in / out)
## Success Criteria
## Open Questions
```

Show full draft of all sections before writing, get approval.
