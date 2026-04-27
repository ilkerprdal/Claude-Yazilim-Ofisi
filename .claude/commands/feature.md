---
description: "Mid-tier scale-adaptive path — story + AC + implementation, but no sprint ceremonies. Use for self-contained features (50-500 LOC, ~1-3 days). Triggers on 'add feature', 'new feature', 'implement X', 'feature ekle', 'yeni özellik'."
allowed-tools: Read, Glob, Grep, Write, Edit, Bash, Task
argument-hint: "[short feature description]"
---

# /feature

The middle tier between `/quick-fix` and a full sprint cycle. For changes
too big to be a one-off fix, but too small to deserve sprint planning, retro,
and ceremony overhead.

### Scale-Adaptive Routing

| Change size | Use this command | Why |
|---|---|---|
| < 50 LOC, no design impact | `/quick-fix` | No process needed |
| 50–500 LOC, single feature, ~1–3 days | **`/feature`** *(this)* | Story + AC, no ceremony |
| > 500 LOC, multi-story, > 3 days | `/sprint-plan` + `/develop-story` | Full sprint loop |

If unsure, ask: *"Does this need sprint-level coordination?"* If no, use `/feature`.

### When to use

Use when ALL of these are true:
- Single, coherent feature (one user-visible capability)
- Estimated 50–500 lines of code total
- Spans 1–3 days of focused work
- Architectural shape is already clear (no new service, no new DB)
- Doesn't conflict with in-flight sprint work
- One specialist (or two consulting horizontally) can deliver it

If any item is false → either use `/quick-fix` (smaller) or `/sprint-plan`
+ `/develop-story` (bigger).

### Examples

- "Add CSV export to the orders list"
- "Add password reset email flow" (existing email infra)
- "Add filter by date range to dashboard"
- "Add rate limiting to public endpoints" (lib already chosen)
- "Implement search-as-you-type on user list"

### Anti-examples

- New service / new database / new auth provider → `/architecture` first
- "Rebuild the dashboard" → multi-story, use sprint
- Cross-team API breaking change → needs full ceremony for coordination
- Anything touching billing / payments / PII model → `/develop-story` + security review

### Steps

1. **Acknowledge scope** to user:
   > "This will be a feature path: lightweight story + AC + implementation
   > + code review. Skipping sprint planning and retro.
   > Estimated size: 50–500 LOC. Confirm? (y/n)"

2. **Quick product framing** (delegate to `product-manager`)
   - Hypothesis (one line: who/what/why)
   - User segment named
   - 3–7 acceptance criteria in Given/When/Then
   - INVEST check — if it fails (not Independent, too Big), surface and offer split

3. **Lightweight story file**
   - Write to `production/stories/F-<short-slug>.md` (F prefix = feature, no sprint ID)
   - Includes: hypothesis, AC, rough size estimate, specialist routing
   - **Skip**: sprint assignment, story-points scoring, dependency graph

4. **Route to specialist** (delegate to `engineering-lead` for routing decision)
   - Backend → `backend-developer`
   - Frontend → `frontend-developer`
   - Both → run sequentially with API-contract handoff
   - Infra/CI → `devops`

5. **Design check** (only if user-facing)
   - If story affects UI: brief `design-lead` consult — wireframe + a11y check
   - If purely backend / infra: skip

6. **Implement**
   - Specialist proposes file list before writing
   - Approval → code + tests together
   - All AC must be checkbox-checked off before moving to review

7. **Code review**
   - `engineering-lead` does a full `/code-review` pass (not the 60s skim)
   - Quality bars, OWASP basics, test coverage, performance sanity

8. **Security check** (conditional)
   - If feature touches auth, PII, payments, file upload, external API:
     also run `security-reviewer` STRIDE pass
   - Otherwise skip

9. **Output**
   - Patch summary, files, test result
   - Story file marked DONE with AC pass status
   - **No retro** triggered automatically — feature is "done" when AC pass
   - **Recommend** to add learnings to `/memory` if anything notable

### Rules

- **One story file** is created (lightweight, no sprint assignment)
- **No sprint update** unless user explicitly asks
- **No retro** triggered (retro is sprint-scoped)
- If during implementation scope balloons past 500 LOC or > 3 days:
  STOP, surface it, suggest splitting or moving to `/develop-story` flow
- **Security exception**: any feature touching auth/PII/payments/files →
  mandatory `security-reviewer` pass, never optional

### Output Format

```
STATUS: COMPLETED | BLOCKED | SCOPE_TOO_BIG
SCOPE: FEATURE
STORY_FILE: [path]
HYPOTHESIS: [one-line]
AC_TOTAL: [count]
AC_MET: [count] / [total]
FILES_CHANGED: [list]
LINES_CHANGED: [count]
TEST: PASS | FAIL | UPDATED
CODE_REVIEW: APPROVED | REVISION | MAJOR_REVISION
SECURITY_CHECK: PASS | CONCERNS | NOT_APPLICABLE
DEVIATIONS: [if any from original AC]
NEXT: [usually nothing — feature is done; or "split into sprint stories"]
```
