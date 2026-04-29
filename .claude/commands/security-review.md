---
description: "On-demand security audit — STRIDE, OWASP Top-10, sensitive-data inventory, compliance smoke. Drives security-reviewer. Triggers on 'security audit', 'security review', 'check vulnerabilities', 'before release security check'."
allowed-tools: Read, Glob, Grep, Bash, Write, Edit, Task
argument-hint: "[scope: 'release' | 'feature [name]' | 'file [path]']"
---

# /security-review

On-demand. Engages `security-reviewer`. The default flow does NOT run this — it
only fires when:
- A feature is risk-flagged by qa (auth / PII / payments / files / migration)
- `/release-check` requires it
- The user explicitly invokes it

### Modes

#### Pre-release audit (default if no argument)

Full sweep:
- STRIDE threat model on architecture
- OWASP Top-10 audit
- Sensitive data inventory
- Compliance smoke (GDPR / PCI / HIPAA — high-level only)
- Dependency CVE scan

Output: `production/qa/security-review-<release>.md`

#### Feature-scoped review

`/security-review feature payment-flow`
- STRIDE on the feature
- OWASP relevant items
- Specific data handled

Output: `docs/security/threat-model-<feature>.md`

#### Code-scoped review

`/security-review file src/auth/login.ts`
- OWASP-targeted code review for that file
- Auth / authz specific checks

Output: inline findings + summary

### Workflow

1. Determine scope from the argument
2. Invoke `security-reviewer` (Task: subagent_type=security-reviewer) with that scope
3. Agent walks STRIDE / OWASP / compliance as relevant
4. Each finding tagged severity: CRITICAL / HIGH / MEDIUM / LOW
5. User approval before writing report

### Rules

- Don't gloss over `NOT_APPLICABLE` — explain why.
- Critical findings BLOCK release. They cannot be marked PASS without a fix.
- Reports include evidence (file:line, command output, screenshot path).
- Compliance scope is high-level. For real legal compliance, recommend a real auditor.

### Output

`security-reviewer` standard output + the markdown report at the path above.
