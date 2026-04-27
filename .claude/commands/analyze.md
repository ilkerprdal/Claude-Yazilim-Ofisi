---
description: "Requirements gathering for new project (FR/NFR/constraints) OR analysis of existing system. Triggers on 'gather requirements', 'analyze the existing system', 'review this code', 'prepare spec', 'analiz', 'analiz et'."
allowed-tools: Read, Glob, Grep, Write, Edit, AskUserQuestion
argument-hint: "[optional: 'new' or 'existing']"
---

# /analyze

Engage `business-analyst`.

Two modes — ask user which:

### Mode 1: New project / feature

Input: `docs/product/concept.md` (if any) or user's verbal description.

#### Steps

1. **Stakeholder question list** — user, system, success, constraints
2. As user answers, fill:

```markdown
# Requirements — [Project/Feature Name]

## Context
[One paragraph — what we're solving and why]

## Stakeholders
- [Role] — [Their interest/impact]

## Functional Requirements (FR)
- FR-001: System must [do X]
- FR-002: User must be able to [Y]
- ...

## Non-Functional Requirements (NFR)
- NFR-001 (Performance): ...
- NFR-002 (Security): ...
- NFR-003 (Accessibility): ...
- NFR-004 (Scale): ...

## Constraints
- [Technological / legal / budget / time]

## Open Questions
- [Not yet answered]

## Sources
- [Which requirement came from which conversation/doc]
```

3. Write to `docs/analysis/requirements.md`

### Mode 2: Existing system analysis

Input: existing code/project.

#### Steps

1. Scan `src/`, `docs/`, `package.json` / `requirements.txt` / `pom.xml` etc.
2. Extract modules and their responsibilities
3. List dependencies (internal/external)
4. Mark unclear / undocumented sections

```markdown
# Existing System Analysis

## Overview
[What the system does — 1 paragraph]

## Modules
| Module | Responsibility | File/Folder |

## External Dependencies
| Service/Library | Used At | Version |

## Data Flow
[Rough diagram or bullets]

## Ambiguities / Gaps
- [Undocumented or unclear sections]

## Impact Zones (if targeting changes)
- [If X changes, Y is affected]
```

3. Write to `docs/analysis/existing-system.md`

### Rules

- Don't assume. List everything you need to ask, don't write before user
  answers
- Each requirement / finding gets a **source** (conversation reference or
  code path)
- Show output draft, get approval before writing
