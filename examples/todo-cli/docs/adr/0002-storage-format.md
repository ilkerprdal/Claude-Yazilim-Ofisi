# ADR 0002 — Storage Format

**Status**: Accepted
**Date**: 2026-04-12
**Deciders**: tech-director + engineering-lead

## Context

Tasks must persist across CLI invocations (FR-004) and survive partial
writes without corruption (NFR-003). Storage must be local-only (NFR-002).

## Options

| Option | Atomicity | Query | File count |
|--------|-----------|-------|------------|
| Plain JSON file | manual via temp+rename | full file rewrite | 1 |
| YAML file | same | same | 1 |
| SQLite (stdlib) | ACID built-in | SQL | 1 (.db file) |
| Append-only log | implicit | scan to query | 1 |

## Decision

**SQLite via stdlib `sqlite3`**.

Reasoning:
- Already in stdlib — no extra dependency
- ACID transactions give us atomicity for free (NFR-003)
- Scales to thousands of tasks without performance hit
- SQL gives flexibility for future features (filter by date, tags)

JSON would have required manual write-temp-then-rename for atomicity,
plus a full file rewrite on every change. Log-only would have required
custom query logic.

## Consequences

- (+) Robust against partial writes (sqlite handles WAL)
- (+) Future-friendly for tags / filtering
- (-) `.db` file isn't human-readable — debugging requires `sqlite3` CLI
- (-) Tests need to use a temp DB, not hand-edited fixtures (mitigated
  with factory functions)

## Implementation Notes

- DB path: `~/.todo-cli/tasks.db`
- Schema in `src/storage/schema.py`, idempotent `CREATE IF NOT EXISTS`
- All queries parameterized (no string concatenation — security)
