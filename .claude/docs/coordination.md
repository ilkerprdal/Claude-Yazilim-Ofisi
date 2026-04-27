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

## Conflict Resolution

| Conflict Type | Resolved By |
|---------------|-------------|
| Design / scope | product-manager |
| Technical / architectural | tech-director |
| Quality / test sufficiency | qa-lead |

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
