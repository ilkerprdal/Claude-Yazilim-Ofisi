---
description: "Pre-release readiness checklist — code, tests, deployment, docs. Triggers on 'are we release ready', 'release checklist', 'check before launch', 'go/no-go'."
allowed-tools: Read, Glob, Grep, Bash
---

# /release-check

Validate every item before going to release. BLOCKING items must pass — no
release otherwise.

### Code
- [ ] All stories `Done`
- [ ] Expected commits on `main`
- [ ] No open critical/high bugs **(BLOCKING)**

### Tests
- [ ] CI pipeline green **(BLOCKING)**
- [ ] Smoke test passing **(BLOCKING)**
- [ ] QA sign-off

### Deployment
- [ ] `.env.example` up to date
- [ ] Migration scripts tested
- [ ] Rollback plan documented **(BLOCKING)**
- [ ] Monitoring / alarms active

### Docs
- [ ] CHANGELOG up to date
- [ ] README reflects changes
- [ ] API change communicated (if any)

### Release Notes
- [ ] User-facing notes ready
- [ ] Changes ordered by priority

### Output

**GO / NO-GO** decision + missing-item list.
Save to `production/releases/[version]-check.md`.
