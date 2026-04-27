# Software Office — Agent Configuration

A small software office living inside a Claude Code session.
10 agents, 19 commands, minimal noise.

## Language

Agents detect the user's language automatically and respond in it.
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
  ux/             # Screen specs (design-lead)
production/
  backlog.md           # Ordered story list
  stories/             # Story / task files
  sprints/             # Sprint plans
  retros/              # Sprint retrospectives
  qa/                  # Test plans, bug reports
  session-state/       # active.md (session context)
```

## Collaboration Protocol

**User in the driver seat. Agents not autonomous.**

Each task: **Question → Options → Decision → Draft → Approval**

- Before Write/Edit, ask "May I write this to [path]?"
- Multi-file changes presented for approval as a set
- No commits without an explicit user request

Detail: @.claude/docs/collaboration.md

## Coordination

**Vertical delegation**: Directors → Leads → Specialists.
**Horizontal consultation**: Same-tier consult but don't decide.
**Conflict**: Design conflicts → product-manager. Technical conflicts → tech-director.

Detail: @.claude/docs/coordination.md

## Coding Standards

@.claude/docs/coding-standards.md

## Context Management

- For long sessions, keep `production/session-state/active.md` live.
- Write documents section-by-section; commit each on approval.
- After compaction, read `active.md` first.

## Project Memory

These files are auto-loaded if present — agents stay consistent with them:

@.claude/memory/technical.md
@.claude/memory/avoid.md
@.claude/memory/process.md
@.claude/memory/domain.md
@.claude/memory/tools.md

Add new lessons via `/memory add [category] [note]`.

## First Session

If the project is fresh, run `/start`.
If you're joining an existing project with prior AI context, run `/takeover` first.
