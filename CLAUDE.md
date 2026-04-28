# Software Office — Agent Configuration

A small software office living inside a Claude Code session.
13 agents, 24 commands, minimal noise.

## Speed Mode (default ON for solo / small team)

This config is tuned for **fast iteration**:

- **Batch approvals**: list ALL planned files in ONE approval at the start of a
  task; proceed without per-file gates after that. Re-approve only if scope
  changes mid-stream.
- **Brief output**: agents end with 1-3 lines (status + next). Full structured
  block only on `BLOCKED`, `FAIL`, or `CONCERNS`.
- **Skip ceremonies for small work**: `/quick-fix` (< 50 LOC) and `/feature`
  (50–500 LOC) bypass sprint planning, retro, and full review chain.
- **Solo delegation shortcut**: orchestrator may go directly to specialist for
  routine work. Lead consultation required only for: architecture changes,
  breaking API changes, auth/PII/payments/files, cross-cutting concerns.
- **Lazy load**: memory and docs files load on demand, not auto-imported.

Override per-session by saying "verbose mode" or "full ceremony".

## Hard Gates (always apply, even in speed mode)

These NEVER auto-approve, regardless of mode:

- **Destructive ops**: `rm -rf`, `DROP TABLE`, force-push, delete branch
- **Secret-touching**: writing or reading `.env`, key files, credentials
- **DB migrations**: schema changes (forward + rollback both gated)
- **Public API breaking changes**: must produce migration guide
- **Production deploy**: explicit user confirm + release-check pass

## Language

Agents detect the user's language and respond in it.
Default: English. Tech terms (API, REST, ADR, Docker) stay in English.

## Tech Stack

- **Language / Framework**: [To be configured]
- **Database**: [To be configured]
- **Version Control**: Git
- **Test Framework**: [To be configured]

## Folder Layout

```
src/         # Source code
tests/       # Unit + integration tests
docs/
  product/        # Product vision, concept (product-manager)
  analysis/       # Requirements, existing system (business-analyst)
  architecture/   # Architecture (tech-director)
  adr/            # Architecture Decision Records
  ux/             # Screen specs, DESIGN.md, tokens (design-lead)
  api/            # OpenAPI / GraphQL SDL / .proto (engineering-lead)
production/
  backlog.md           # Ordered story list
  stories/             # Story / task files
  sprints/             # Sprint plans
  retros/              # Sprint retrospectives
  qa/                  # Test plans, bug reports
  session-state/       # active.md (session context)
```

## Coordination (one-line summary)

**Director → Lead → Specialist** (vertical). Same-tier may consult but not
decide for each other (horizontal). Conflicts: design/scope → product-manager;
technical → tech-director; quality → qa-lead.

In speed mode, orchestrator may skip Lead for routine specialist work
(see Speed Mode above).

Full rules: load `.claude/docs/coordination.md` on demand.

## Project References (load when relevant, NOT auto-loaded)

The following live under `.claude/` — load only when the current task needs them:

- `.claude/docs/collaboration.md` — full Q→O→D→D→A protocol (only needed
  when verbose mode is invoked or user explicitly disables speed mode)
- `.claude/docs/coordination.md` — full delegation rules
- `.claude/docs/coding-standards.md` — code conventions
- `.claude/memory/technical.md` — accumulated tech learnings
- `.claude/memory/avoid.md` — patterns to avoid
- `.claude/memory/process.md` — workflow learnings
- `.claude/memory/domain.md` — domain knowledge
- `.claude/memory/tools.md` — tool quirks

Read these via Read tool when the topic comes up. Do NOT preload all of
them every turn — wastes tokens.

## Context Management

- For long sessions, keep `production/session-state/active.md` live.
- Write documents section-by-section; one batched approval per section.
- After compaction, read `active.md` first.

## First Session

- Fresh project: `/start`
- Existing project with prior AI context (Cursor/Copilot/Aider): `/takeover`
- Add learnings: `/memory add [category] [note]`
