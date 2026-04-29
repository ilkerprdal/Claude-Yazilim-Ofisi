---
description: "Default flow for any non-trivial change: researcher → qa → tech-lead → developer(s) → tech-lead review → qa validation. No sprint, no retro, no standup. Triggers on 'add feature', 'new feature', 'implement X', 'feature ekle', 'yeni özellik'."
allowed-tools: Read, Glob, Grep, Write, Edit, Bash, Task
argument-hint: "[short feature description]"
---

# /feature

The main flow. For anything bigger than a one-line fix and smaller than
a new system. Five steps, linear, no ceremonies.

### When to use

Default for almost everything. Use ALL of these as a sanity check:

- One coherent thing the user can describe in a sentence
- Architectural shape is clear (no new service, no new framework)
- Doesn't conflict with in-flight work
- Won't span a week of focused work

If it's < ~50 LOC and trivially scoped → `/quick-fix`.
If it's a new service / new framework / new auth model → talk to **cto** first.

### Flow

```
researcher → qa (analysis) → tech-lead (tasks) → developer(s) → tech-lead (review) → qa (validation) → done
```

cto, security-reviewer, devops are **on-call only** — pulled in when their
trigger fires, never as default steps.

### Steps

1. **Acknowledge scope** — one line:
   > "Running /feature: researcher → qa → tech-lead → developer. No sprint, no retro. cto/security/devops only if a trigger fires."

2. **researcher** (Task: subagent_type=researcher)
   - Investigates the topic against the codebase + relevant docs
   - Returns evidence (files, line numbers, prior art) and open questions
   - Does NOT recommend an approach

3. **qa** — Mode A analysis (Task: subagent_type=qa)
   - Reads researcher's brief + user's ask
   - Produces hypothesis + AC + test plan + out-of-scope + risk flags
   - Writes `production/qa/spec-<slug>.md`
   - **Risk flag fires?** (auth / PII / payments / files / migration) → also invoke `security-reviewer` before tech-lead

4. **tech-lead** — task breakdown (Task: subagent_type=tech-lead)
   - Reads qa's spec
   - Splits into independent, named-files, AC-mapped tasks
   - Notes which can run in parallel
   - Writes `production/stories/<slug>.md`

5. **developer(s)** (Task: subagent_type=developer — may run multiple in parallel for parallelizable tasks)
   - Each picks a task; implements code + tests; runs them; reports
   - Stays inside named files; surfaces if scope leaks

6. **tech-lead** — review (Task: subagent_type=tech-lead)
   - Quality bars, AC coverage, security smoke
   - Verdict: APPROVE / APPROVE_WITH_NITS / REQUEST_CHANGES / BLOCK
   - REQUEST_CHANGES → loop back to developer
   - BLOCK → escalate to cto

7. **qa** — Mode B validation (Task: subagent_type=qa)
   - Runs the full test suite, walks each AC against evidence
   - GATE: PASS / CONCERNS / FAIL
   - Writes `production/qa/validation-<slug>.md`
   - FAIL → loop back to developer

8. **Done** — feature is "done" when qa GATE = PASS.

### Conditional Steps

- **Infra / pipeline / Dockerfile changes** in the task list → invoke `devops` for that task only.
- **Risk-flagged feature** (qa flagged auth/PII/payments/files/migration) → invoke `security-reviewer` between qa-analysis and tech-lead breakdown.
- **API contract change with consumers / new dependency / new auth model** → invoke `cto` for the call before tech-lead breaks tasks.

### Rules

- One spec file (qa) + one task list (tech-lead) per feature. No sprint assignment, no story points, no retro.
- If during implementation the developer surfaces "this is bigger than I thought" → STOP, send back to qa to re-spec or to cto if architecture is the issue.
- Security exception: any feature touching auth / PII / payments / files **must** go through `security-reviewer` — never optional.
- Don't skip qa validation. "tech-lead approved" is not the same as "qa says it works".

### Output Format

```
STATUS: COMPLETED | BLOCKED | SCOPE_TOO_BIG
SCOPE: FEATURE
SPEC_FILE: [qa spec path]
TASK_FILE: [tech-lead task list path]
VALIDATION_FILE: [qa validation path]
HYPOTHESIS: [one-line]
AC_TOTAL: [count]
AC_MET: [met / total]
TASKS: [count] — [parallelizable count]
FILES_CHANGED: [list]
LOC_CHANGED: [count]
TECH_LEAD_VERDICT: APPROVE | APPROVE_WITH_NITS | REQUEST_CHANGES | BLOCK
QA_GATE: PASS | CONCERNS | FAIL
SECURITY_INVOKED: YES | NO | NOT_REQUIRED
DEVOPS_INVOKED: YES | NO | NOT_REQUIRED
CTO_INVOKED: YES | NO | NOT_REQUIRED
NEXT: [usually nothing — feature done; or "fix flagged AC" / "scope split"]
```
