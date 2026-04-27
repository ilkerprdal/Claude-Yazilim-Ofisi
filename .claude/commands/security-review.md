---
description: "Full security audit — STRIDE threat model, OWASP Top-10, sensitive data inventory, compliance checks. Triggers on 'security audit', 'security review', 'check vulnerabilities', 'before release security check'."
allowed-tools: Read, Glob, Grep, Bash, Write, Edit
argument-hint: "[scope: 'release' | 'feature [name]' | 'file [path]']"
---

# /security-review

Engage `security-reviewer`.

### Modes

#### Pre-release audit
Default if no argument. Full sweep:
- STRIDE threat model on architecture
- OWASP Top-10 audit
- Sensitive data inventory
- Compliance checks (if applicable)
- Dependency CVE scan

Output: `production/qa/security-review-[release].md`

#### Feature-scoped review
`/security-review feature payment-flow`
- STRIDE on the feature
- OWASP relevant items
- Specific data handled

Output: `docs/security/threat-model-payment-flow.md`

#### Code-scoped review
`/security-review file src/auth/login.ts`
- OWASP-targeted code review for that file
- Authentication/authorization specific checks

Output: inline findings + summary report

### Workflow

1. Determine scope from argument
2. Engage `security-reviewer` with the scope
3. Agent walks through STRIDE / OWASP / compliance as relevant
4. Each finding tagged with severity (CRITICAL / HIGH / MEDIUM / LOW)
5. Recommendations prioritized
6. User approval before writing report

### Rules

- Don't gloss over `NOT_APPLICABLE` — explain why
- Critical findings BLOCK release (cannot be marked PASS without fix)
- Reports include evidence (file:line, command output, screenshot path)
- Compliance scope: high-level only — for legal compliance, recommend
  a real auditor

### Output

`security-reviewer` standard output format. Plus a release/feature
markdown report.
