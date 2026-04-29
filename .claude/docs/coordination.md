# Coordination Rules

## The Flow

```
researcher → qa (analysis) → tech-lead (tasks) → developer(s) → tech-lead (review) → qa (validation) → done
```

This is the default for `/feature` and `/bug-fix`. Linear, no ceremonies.

`/quick-fix` short-circuits: developer + tech-lead glance.

## On-Call Roles

These three are **NOT** in the default flow. They run only when their trigger fires:

| Role | Trigger |
|---|---|
| **cto** | Stack pick, architectural change, breaking API, scope conflict, release sign-off |
| **security-reviewer** | qa flagged risk (auth / PII / payments / files / migration), pre-release audit, explicit `/security-review` |
| **devops** | Pipeline / Dockerfile / deployment / observability work in the task list |

If qa or tech-lead pulls one of these in for routine work, that role returns it.

## Conflict Resolution

| Conflict | Resolved by |
|---|---|
| Tech / architecture / scope / breaking change | cto |
| Test sufficiency / AC interpretation | qa |
| Code structure / quality / review verdict | tech-lead |

## Parallel Execution

- Multiple developers can run in parallel against tech-lead's task list as long as the tasks are independent (no shared files).
- Tech-lead marks parallelizable tasks explicitly. If two tasks touch the same file, they run sequentially.
- researcher, qa-analysis, tech-lead-breakdown are sequential — each consumes the previous step's output.

## Model Assignments

| Model | Usage |
|---|---|
| Haiku | Read-only, formatting, simple listing |
| Sonnet | Default — researcher, qa, tech-lead, developer, devops, security-reviewer |
| Opus | cto only (high-stakes decisions, multi-document synthesis) |

## What's NOT Here

No sprint, no retro, no standup, no backlog refinement, no story points. If you
miss those, you're using the wrong tool — pick a heavier framework. This setup
is for solo / small teams that want flow over ceremony.
