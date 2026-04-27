---
description: "Review a file or change set against code standards, architecture, test sufficiency. Triggers on 'code review', 'review PR', 'check code quality', 'kod inceleme'."
allowed-tools: Read, Glob, Grep, Bash
argument-hint: "[file path, or empty = recent changes]"
---

# /code-review

Engage `engineering-lead`.

### Checklist

**Code Quality**
- [ ] Names clear?
- [ ] Functions single-responsibility?
- [ ] Duplicated code?
- [ ] Magic numbers / hardcoded values?

**Architectural Fit**
- [ ] Layer boundaries respected? (UI ↔ logic ↔ data)
- [ ] Aligned with relevant ADR?
- [ ] Public API changes? (documented?)

**Tests**
- [ ] Story acceptance criteria tested?
- [ ] Edge cases covered?
- [ ] Tests deterministic?

**Security & Errors**
- [ ] User input validated?
- [ ] Secrets leaked into code?
- [ ] Error messages leak internal info?

### Output

Markdown report: **APPROVED / NEEDS REVISION / MAJOR REVISION NEEDED**
Each finding gets file:line reference.
