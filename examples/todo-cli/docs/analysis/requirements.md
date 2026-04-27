# Requirements — todo-cli

## Context

A single-user terminal-based task tracker. Local-only. No network calls,
no accounts, no sync. The user is a developer who runs `todo` from any
directory and gets immediate response.

## Stakeholders

- **Primary user**: a developer using the CLI directly
- **No secondary stakeholders** (no admin, no PM persona — solo tool)

## Functional Requirements

- **FR-001**: User can add a task with a single-line title
  via `todo add "title"`
- **FR-002**: User can list all open tasks via `todo list`
- **FR-003**: User can mark a task done via `todo done <id>`
- **FR-004**: Tasks persist across CLI invocations (survive process exit)
- **FR-005**: Tasks have a stable, short ID for referencing
- **FR-006**: System rejects empty titles with a clear error
- **FR-007**: System rejects unknown task IDs in `done` with a clear error

## Non-Functional Requirements

- **NFR-001 (Performance)**: Cold-start to output < 200 ms on a modern laptop
- **NFR-002 (Security)**: All data stays on the local machine; no network calls
- **NFR-003 (Resilience)**: Storage writes are atomic — partial write must
  not corrupt the database
- **NFR-004 (Portability)**: Runs on macOS, Linux, Windows with Python 3.11+
- **NFR-005 (Observability)**: `--verbose` flag for debugging; otherwise quiet
- **NFR-006 (Simplicity)**: Zero external runtime dependencies beyond Click

## Constraints

- **Python 3.11+** target (developer audience already has it)
- **Single-binary feel** — no daemons, no servers, no background processes
- **Local file** for storage (no DB server)
- **MIT-friendly** — only permissive-licensed dependencies

## Open Questions

(none — closed during /architecture)

## Sources

- `docs/product/concept.md` — problem and scope
- User input during `/analyze` session 2026-04-12
