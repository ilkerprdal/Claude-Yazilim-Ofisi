---
description: "End-to-end QA→Dev→QA bug fix loop, regression test required. Triggers on 'fix bug X', 'resolve bug 042', 'fix this report'."
allowed-tools: Read, Glob, Grep, Write, Edit, Bash, Task
argument-hint: "[bug-id or path to report, e.g. 042 or production/qa/bugs/042-login-crash.md]"
---

# /bug-fix

QA → Dev → QA closed loop.

### Flow

1. **Load context**
   - `production/qa/bugs/[id]-*.md`
   - Find related story (if any)
   - Identify affected code files

2. **Form hypothesis**
   - Match repro steps to code
   - List 1-3 possible causes
   - Present to user: "Most likely: [X]. Correct?"

3. **Route to right agent**
   - Backend bug → `backend-developer`
   - Frontend bug → `frontend-developer`
   - Infrastructure / CI bug → `devops`

4. **Fix** (on agent side)
   - Present fix, get approval
   - **Write regression test** (so this bug doesn't recur)
   - Verify existing tests still pass

5. **QA gate**
   - `qa-lead` agent:
     - Run repro steps → bug gone?
     - Regression test present and passing?
     - No side effects?
   - GATE: PASS → mark bug `Resolved`
   - GATE: FAIL → loop back to step 4

6. **Closure**
   - Add `Resolution` section to bug report:
     ```
     ## Resolution
     **Date**: yyyy-mm-dd
     **Files changed**: [list]
     **Regression test**: tests/regression/bug-042.test.js
     **Commit**: [hash if any]
     ```
   - Note in `production/standup-log.md`

### Rules

- Don't close without a test
- "Don't know the cause but I fixed it" → reject, validate hypothesis
- After 3 attempts unresolved → `STATUS: BLOCKED`, return to user

### Output

```
STATUS: COMPLETED | BLOCKED
BUG_ID: [id]
ROOT_CAUSE: [one-sentence actual cause]
FILES_CHANGED: [list]
REGRESSION_TEST: [file path]
QA_GATE: PASS | FAIL
NEXT: [if any]
```
