---
description: "Audit a shipped UI against the design-lead's spec at three viewports with a11y, console, and token-discipline checks. Triggers on 'design review', 'review UI', 'tasarim incele', after a UI story marked Review."
allowed-tools: Read, Glob, Grep, Bash, Task
argument-hint: "[screen name or story id, or empty = recent UI changes]"
---

# /design-review

Engage `design-reviewer`. Runs the 7-phase audit, returns severity-tagged
findings.

### Inputs Loaded

- `docs/ux/<screen>.md` (target spec)
- `docs/ux/DESIGN.md` (brand voice, color roles, do's & don'ts)
- `tokens/*.tokens.json` (token source of truth)
- `docs/ux/components-diff.md` (reuse intent)
- frontend-developer's last output report (residual debt)

If any are missing → `[Blocker] Missing spec` and stop.

### 7 Phases

1. Live preview at 1440×900
2. Interactive states (default / hover / focus / active / disabled / loading)
3. Responsive sweep at 375 / 768 / 1440
4. WCAG 2.2 AA (keyboard, screen reader, contrast, touch targets, reduced motion, drag alternative)
5. Forms / overflow / edge states
6. Token & component-reuse audit
7. Console / network / content clarity + anti-pattern detector

### Severity Tags

| Tag | Effect |
|---|---|
| `[Blocker]` | Must fix before merge |
| `[High]` | Fix before merge |
| `[Medium]` | Same-PR if cheap, else follow-up |
| `[Nit]` | Author's discretion |

### Output

Acknowledgment (2 sentences naming what worked) + verdict
(`APPROVE / APPROVE_WITH_NITS / REQUEST_CHANGES / BLOCK`) + severity-tagged
findings list with file:line references where possible.

### Routing

- Spec gap → back to **design-lead**
- Code-level fix → back to **frontend-developer**
- Performance budget exceeded → escalate to **tech-director**
- Regulatory / legal (EAA, KVKK) → escalate to **product-manager**
