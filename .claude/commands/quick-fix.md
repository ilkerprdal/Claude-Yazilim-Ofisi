---
description: "Scale-adaptive lightweight fix path — skips story / sprint / ceremonies. Use for small bugs, typos, dependency bumps, one-line config changes. Triggers on 'quick fix', 'small fix', 'just fix this', 'one-liner', 'hızlı düzelt'."
allowed-tools: Read, Glob, Grep, Write, Edit, Bash, Task
argument-hint: "[short description of the fix]"
---

# /quick-fix

For small changes that don't deserve a full sprint cycle. Skips: story
creation, sprint planning, retro. Keeps: code review, security, tests
(if reasonable).

### When to use

Use when ALL of these are true:
- Change is < ~50 lines of code
- No new architectural decision needed
- No new dependency (or just bumping one)
- Test exists for related path (or trivial to add one)
- Won't take more than ~30 minutes

If any one is false → use the full `/develop-story` flow instead.

### Examples

- Typo in error message
- Dependency security bump (`requests` 2.31 → 2.32)
- Off-by-one in pagination
- Missing null-check in handler
- Adding a missing log line
- README correction
- Config tweak

### Anti-examples (use `/develop-story` instead)

- New feature, even small
- Bug that requires changing data model / migration
- Anything touching auth / payments / PII
- Refactor across files
- Any change you'd want to review with another engineer first

### Steps

1. **Acknowledge scope** to user:
   > "This will be a quick-fix path: no story, no sprint update, no retro.
   > Just: minimal change + relevant test + brief code review.
   > Confirm? (y/n)"

2. **Identify files**
   - Read the description
   - Locate the file(s) touched
   - If unclear: ask the user, don't guess

3. **Route to right specialist**
   - Backend code → `backend-developer`
   - Frontend / UI → `frontend-developer`
   - CI / Docker / env → `devops`
   - Docs only → no agent, just the main session

4. **Implement**
   - Show the diff before writing
   - Get user approval
   - Write change
   - Run existing tests; add a regression test ONLY if change introduces a
     new code path that isn't covered

5. **Quick review**
   - `engineering-lead` does a 60-second pass: linter clean? secret leaked?
     obvious mistake? Skip the full /code-review checklist.

6. **Output**
   - Patch summary
   - Files changed
   - Test result
   - **Recommend** (don't enforce):
     - If user asked for a quick fix but the change exposed something
       larger → suggest opening a follow-up story
     - If a regression test was added → mention to add to memory if
       relevant pattern

### Rules

- **No story file created** for the fix itself (it's not a tracked unit)
- **No sprint update** unless user asks
- If during the fix you discover the scope is bigger than expected:
  STOP, surface it, suggest switching to `/develop-story`
- **Security exception**: if the "quick fix" is a security patch, also
  trigger `security-reviewer` for a sanity check — never quick-fix-only
  for security

### Output Format

```
STATUS: COMPLETED | BLOCKED | SCOPE_TOO_BIG
SCOPE: QUICK_FIX
FILES_CHANGED: [list]
LINES_CHANGED: [count]
TEST: PASS | UPDATED | NOT_NEEDED
QUICK_REVIEW: PASS | CONCERNS ([list])
FOLLOW_UP_RECOMMENDED: [if anything bigger surfaced — describe]
NEXT: [usually nothing — fix is done]
```
