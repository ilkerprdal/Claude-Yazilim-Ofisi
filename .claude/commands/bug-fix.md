---
description: "End-to-end bug fix loop with regression test required. Researcher locates the bug, developer fixes it, qa validates. Triggers on 'fix bug X', 'resolve bug 042', 'fix this report'."
allowed-tools: Read, Glob, Grep, Write, Edit, Bash, Task
argument-hint: "[bug-id or path to report, e.g. 042 or production/qa/bugs/042-login-crash.md]"
---

# /bug-fix

researcher → developer → qa loop. Regression test is non-negotiable.

### Flow

1. **Load context**
   - `production/qa/bugs/[id]-*.md` (or the path the user passed)
   - Identify affected code files

2. **researcher** (Task: subagent_type=researcher)
   - Reproduce in the code: walk repro steps, find the path
   - Form 1–3 candidate causes with evidence (file:line)
   - Note any prior incidents on the same area
   - Does NOT propose a fix — just facts

3. **Validate hypothesis with user**
   > "Most likely: [X] (evidence: file:line). Correct?"
   - User confirms → continue
   - User pushes back → researcher digs again

4. **developer** (Task: subagent_type=developer)
   - Implement the fix on the validated cause
   - **Write a regression test** that reproduces the bug pre-fix
   - Verify existing tests still pass
   - Surface if scope is bigger than expected

5. **qa gate** (Task: subagent_type=qa, Mode B)
   - Run repro steps → bug gone?
   - Regression test present and passing?
   - No side effects in adjacent tests?
   - GATE: PASS → mark bug Resolved
   - GATE: FAIL → loop to step 4

6. **Closure** — append to the bug report:
   ```
   ## Resolution
   **Date**: yyyy-mm-dd
   **Root cause**: [one sentence]
   **Files changed**: [list]
   **Regression test**: tests/regression/bug-<id>.test.*
   **Commit**: [hash if any]
   ```

### Rules

- Don't close without a regression test.
- "Don't know the cause but I fixed it" → reject; researcher digs again.
- 3 attempts unresolved → `STATUS: BLOCKED`, return to user.
- Bug touches auth / PII / payments / files → invoke `security-reviewer` after the fix and before closure.
- Bug is in CI / pipeline / Dockerfile → use `devops` instead of `developer`.

### Output

```
STATUS: COMPLETED | BLOCKED
BUG_ID: [id]
ROOT_CAUSE: [one sentence — the actual cause]
FILES_CHANGED: [list]
REGRESSION_TEST: [file path]
QA_GATE: PASS | FAIL
SECURITY_INVOKED: YES | NO | NOT_REQUIRED
NEXT: [if any]
```
