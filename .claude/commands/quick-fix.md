---
description: "Lightweight path: skips researcher / qa-analysis / tech-lead — goes straight to developer with a quick tech-lead glance. Use for small bugs, typos, dependency bumps, one-line config changes. Triggers on 'quick fix', 'small fix', 'just fix this', 'one-liner', 'hızlı düzelt'."
allowed-tools: Read, Glob, Grep, Write, Edit, Bash, Task
argument-hint: "[short description of the fix]"
---

# /quick-fix

For small changes that don't deserve the full flow. Skip researcher, qa
analysis, task breakdown. Keep: a tech-lead 60-second sanity pass and a
relevant test (if reasonable).

### When to use

Use when ALL of these are true:

- Change is < ~50 lines of code
- No new architectural decision needed
- No new dependency (or just bumping one)
- Test exists for related path (or trivial to add one)
- Won't take more than ~30 minutes

If any one is false → `/feature` instead.

### Anti-examples (use `/feature`)

- Any new feature, even small
- Bug that requires changing data model / migration
- Anything touching auth / payments / PII / files
- Refactor across files
- Anything you'd want a second engineer to look at first

### Steps

1. **Acknowledge scope** — one line:
   > "Running /quick-fix: developer + tech-lead glance. No researcher, no qa spec. Confirm? (y/n)"

2. **Identify files** — read the description, locate the file(s). If unclear, ask the user.

3. **developer** (Task: subagent_type=developer)
   - Show the diff before writing
   - Get user approval
   - Write the change
   - Run existing tests
   - Add a regression test ONLY if the change opens a new code path

4. **tech-lead 60-second pass** (Task: subagent_type=tech-lead)
   - Linter clean? Secret leaked? Obvious mistake?
   - Skip the full review checklist — this is a glance, not a review

5. **Output** — patch summary, files, test result.

### Rules

- No spec file, no task file, no validation file.
- If during the fix scope balloons past 50 LOC → STOP, switch to `/feature`.
- Security exception: if the "quick fix" is itself a security patch, also invoke `security-reviewer` for a sanity check — never quick-fix-only for security.
- Infra / pipeline / Dockerfile fix → invoke `devops` instead of `developer`.

### Output Format

```
STATUS: COMPLETED | BLOCKED | SCOPE_TOO_BIG
SCOPE: QUICK_FIX
FILES_CHANGED: [list]
LINES_CHANGED: [count]
TEST: PASS | UPDATED | NOT_NEEDED
QUICK_REVIEW: PASS | CONCERNS ([list])
FOLLOW_UP_RECOMMENDED: [if anything bigger surfaced]
NEXT: [usually nothing — fix is done]
```
