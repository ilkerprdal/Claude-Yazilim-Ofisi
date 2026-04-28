# Coordination Rules

## Vertical Delegation

```
Directors → Leads → Specialists
```

- Directors don't delegate directly to specialists (go through leads)
- Specialists don't escalate directly to directors (go through leads)
- Exception: lead absent or emergency

## Horizontal Consultation

Same-tier agents can consult, but cannot decide for each other:

- backend-developer ↔ frontend-developer (API contract)
- engineering-lead ↔ qa-lead (test strategy)
- design-lead ↔ frontend-developer (feasibility, animation cost, browser support)
- frontend-developer → design-reviewer (UI is shipped; review runs after)

## UI Pipeline (the design → dev → review loop)

For any user-facing change:

```
design-lead → frontend-developer → design-reviewer
   (spec)        (implementation)      (audit)
```

- **design-lead** emits: `docs/ux/<screen>.md`, `docs/ux/DESIGN.md`, `tokens/*.tokens.json`, `docs/ux/components-diff.md`.
- **frontend-developer** consumes the spec, ships code + Storybook stories + tests, reports residual debt severity-tagged.
- **design-reviewer** runs the 7-phase Playwright audit and returns severity-tagged findings. Frontend-developer fixes; review iterates.

design-reviewer is **non-negotiable** before merging UI. It's not a code review (engineering-lead) — it's a product review.

## Conflict Resolution

| Conflict Type | Resolved By |
|---------------|-------------|
| Design / scope | product-manager |
| Technical / architectural | tech-director |
| Quality / test sufficiency | qa-lead |
| UI spec vs implementation drift | design-lead (spec authoritative unless infeasible — then escalate) |

## Parallel Execution

- **Maximum 2 agents in parallel** (avoid race conditions on file writes)
- Agents writing to the same file MUST run sequentially
- Independent reads can be parallel

## Model Assignments

| Model | Usage |
|-------|-------|
| Haiku | Read-only, formatting, simple listing |
| Sonnet | Implementation, review, single-system analysis (default) |
| Opus | Multi-document synthesis, high-stakes decision |

Commands default to Sonnet. `/help` is Haiku, `/architecture` and
`/release-check` are Opus.
