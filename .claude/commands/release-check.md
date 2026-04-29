---
description: "Pre-release GO / NO-GO sign-off. Drives cto for the final call. Triggers on 'are we release ready', 'release checklist', 'check before launch', 'go/no-go'."
allowed-tools: Read, Glob, Grep, Bash, Task
---

# /release-check

Pre-release readiness. cto signs off. BLOCKING items must pass — no release otherwise.

### Flow

1. Walk the checklist below, gather evidence per item.
2. Invoke `cto` (Task: subagent_type=cto) with the evidence.
3. cto returns GO or NO-GO with rationale.
4. Write `production/releases/<version>-decision.md`.

### Checklist

**Code (BLOCKING marked)**
- [ ] All in-flight features have qa GATE = PASS
- [ ] No open critical / high bugs **(BLOCKING)**
- [ ] Expected commits on `main`

**Tests (BLOCKING)**
- [ ] CI pipeline green **(BLOCKING)**
- [ ] Smoke test passing on stage **(BLOCKING)**

**Deployment (BLOCKING)**
- [ ] `.env.example` up to date
- [ ] Migration scripts tested forward + rollback
- [ ] Rollback plan documented and tested **(BLOCKING)**
- [ ] Monitoring + alerts active **(BLOCKING)**

**Security (conditional BLOCKING)**
- [ ] If release touches auth / PII / payments / files: `security-reviewer` ran, no FAIL items **(BLOCKING when conditional triggers)**
- [ ] Dependency CVE scan run; no unpatched critical / high

**Docs (non-blocking but flagged)**
- [ ] CHANGELOG up to date
- [ ] README reflects changes
- [ ] API change communicated (if any)

### Output

GO / NO-GO + missing-item list. Save to `production/releases/<version>-decision.md`.

```
STATUS: COMPLETED
VERDICT: GO | NO_GO
BLOCKING_FAILS: [list]
NON_BLOCKING_GAPS: [list]
SECURITY_INVOKED: YES | NO | NOT_REQUIRED
WROTE: production/releases/<version>-decision.md
NEXT: ship | fix [item] then re-run
```
