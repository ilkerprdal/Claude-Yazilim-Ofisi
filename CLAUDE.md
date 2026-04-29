# Software Office — Lean Mode

A small software office living inside a Claude Code session.
**7 agents. 9 commands. No sprint, no retro, no standup. Linear flow.**

## The Flow

```
researcher → qa (analysis) → tech-lead (tasks) → developer(s) → tech-lead (review) → qa (validation) → done
```

That's `/feature` — the default path. `/quick-fix` skips researcher and qa
analysis. `/bug-fix` runs researcher → developer → qa.

cto, security-reviewer, devops are **on-call only** — pulled in when their
trigger fires, never as default steps.

## The 7 Agents

| Tier | Agent | Role |
|---|---|---|
| Top (on-call) | **cto** | Stack pick, architecture, breaking change, scope conflict, release sign-off |
| Flow | **researcher** | Investigates topic, returns evidence (no opinion) |
| Flow | **qa** | Spec + AC + test plan, then validates the developer's output |
| Flow | **tech-lead** | Splits qa's spec into tasks, reviews developer's code |
| Flow | **developer** | Implements end-to-end (backend, frontend, tests) — multiple in parallel allowed |
| On-call | **security-reviewer** | STRIDE / OWASP audit when qa flags risk or release demands it |
| On-call | **devops** | CI/CD / Docker / deploy / observability when needed |

## The 9 Commands

| Command | Purpose |
|---|---|
| `/start` | Detect stack, suggest next |
| `/takeover` | Import prior AI context (Cursor/Copilot/etc.) |
| `/help` | Smart suggestion + command list |
| `/feature` | Default flow for any change |
| `/quick-fix` | Tiny change — skip the flow |
| `/bug-fix` | researcher → developer → qa loop |
| `/security-review` | On-demand security audit |
| `/release-check` | Pre-release GO/NO-GO (cto signs off) |
| `/memory` | View / add project learnings |

## Speed Mode (always on)

- **Batch approvals**: list all planned files in ONE approval; proceed without per-file gates after that.
- **Brief output**: agents end with 1–3 lines (status + next). Full structured block only on `BLOCKED` / `FAIL` / `CONCERNS`.
- **Parallel developers**: tech-lead marks tasks parallelizable; multiple developer instances run simultaneously.
- **Lazy load**: memory and docs files load on demand, not auto-imported.

## Hard Gates (never auto-approve)

- **Destructive ops**: `rm -rf`, `DROP TABLE`, force-push, delete branch
- **Secret-touching**: writing or reading `.env`, key files, credentials
- **DB migrations**: schema changes (forward + rollback both gated)
- **Public API breaking changes**: must produce migration guide
- **Production deploy**: explicit user confirm + `/release-check` pass

## Language

Agents detect the user's language and respond in it. Default: English.
Tech terms (API, REST, ADR, Docker) and code stay in English.

## Tech Stack

- **Language / Framework**: [To be configured]
- **Database**: [To be configured]
- **Version Control**: Git
- **Test Framework**: [To be configured]

## Folder Layout

```
src/                  # Source code
tests/                # Unit + integration tests
docs/
  architecture/       # cto's architecture docs
  adr/                # Architecture Decision Records
  api/                # OpenAPI / GraphQL SDL / .proto (when contract change)
  security/           # security-reviewer threat models
production/
  qa/
    spec-*.md         # qa Mode A specs
    validation-*.md   # qa Mode B validations
    bugs/             # bug reports
    security-review-*.md
  stories/            # tech-lead task breakdowns
  releases/           # cto GO/NO-GO decisions
  session-state/
    active.md         # session context (read after compaction)
```

## Coordination (one-line summary)

Linear flow: researcher → qa → tech-lead → developer → tech-lead → qa.
On-call: cto (decisions), security-reviewer (risk), devops (infra).
Conflicts: tech/scope → cto; test sufficiency → qa; code quality → tech-lead.

Full rules: load `.claude/docs/coordination.md` on demand.

## Project References (load when relevant, NOT auto-loaded)

- `.claude/docs/coordination.md` — full delegation rules
- `.claude/docs/collaboration.md` — speed/verbose mode + hard gates
- `.claude/docs/coding-standards.md` — code conventions
- `.claude/memory/technical.md` — accumulated tech learnings
- `.claude/memory/avoid.md` — patterns to avoid
- `.claude/memory/process.md` — workflow learnings
- `.claude/memory/domain.md` — domain knowledge
- `.claude/memory/tools.md` — tool quirks

Read these via Read tool when the topic comes up. Don't preload all of them.

## Context Management

- For long sessions, keep `production/session-state/active.md` live.
- Write documents section-by-section; one batched approval per section.
- After compaction, read `active.md` first.

## First Session

- Fresh project: `/start`
- Existing project with prior AI context (Cursor/Copilot/Aider): `/takeover`
- Add learnings: `/memory add [category] [note]`
