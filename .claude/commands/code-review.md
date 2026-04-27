---
description: "Review a file or change set against code standards, architecture, test sufficiency, security, performance. Triggers on 'code review', 'review PR', 'check code quality', 'kod inceleme'."
allowed-tools: Read, Glob, Grep, Bash
argument-hint: "[file path, or empty = recent changes]"
---

# /code-review

Engage `engineering-lead`. The lead applies its full quality bars and runs
through the checklist below.

### Checklist

#### Code Quality
- [ ] Names clear and intentional?
- [ ] Functions single-responsibility?
- [ ] No duplicated code (DRY but not over-abstracted)?
- [ ] No magic numbers / hardcoded values?
- [ ] Function < 50 lines, file < 400 lines (or justified)?
- [ ] Cyclomatic complexity < 10 per function?

#### Architectural Fit
- [ ] Layer boundaries respected? (UI ↔ logic ↔ data)
- [ ] Aligned with relevant ADR?
- [ ] Public API changes? (documented?)
- [ ] No circular dependencies introduced?

#### Tests
- [ ] Story acceptance criteria tested?
- [ ] Edge cases covered (null/empty/boundary)?
- [ ] Tests deterministic?
- [ ] Coverage meets target (70% standard, 90% critical paths)?

#### Security (OWASP Top-10 lens)
- [ ] **Access control**: every operation checks authorization?
- [ ] **Injection**: parameterized queries / no string concat in SQL/cmd?
- [ ] **Crypto**: sensitive data encrypted in transit + at rest?
- [ ] **Sensitive data**: no PII / tokens / passwords in logs or errors?
- [ ] **Dependencies**: any with known CVEs?
- [ ] **Authentication**: session timeout, password policy, MFA where needed?
- [ ] **Logging**: auth failures + sensitive ops logged?
- [ ] **Input validation**: whitelist + type + length on every external input?

#### Performance
- [ ] No obvious N+1 queries?
- [ ] No tight loops blocking event loop / main thread?
- [ ] Resource cleanup (connections, files, timers)?
- [ ] Pagination for potentially large result sets?

#### Errors & Observability
- [ ] Error messages don't leak internal info?
- [ ] Structured logging with context (request_id, user_id)?
- [ ] No bare `catch` swallowing exceptions?

### Output

Markdown report with verdict: **APPROVED / NEEDS REVISION / MAJOR REVISION NEEDED**

Each finding gets **file:line** reference + severity (BLOCKER / MAJOR / MINOR).

```
STATUS: COMPLETED
VERDICT: APPROVED | NEEDS_REVISION | MAJOR_REVISION
QUALITY_BARS: PASS | VIOLATIONS ([count])
SECURITY: PASS | CONCERNS | FAIL
PERFORMANCE: PASS | CONCERNS
TESTS: PASS | INSUFFICIENT
FINDINGS: [count by severity]
NEXT: [merge / fix / discuss]
```
