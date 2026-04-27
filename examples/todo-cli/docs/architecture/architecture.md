# Architecture — todo-cli

## Overview

A single-process Python CLI built on Click, with a tiny SQLite database
for persistence. Three layers: command parsing (Click) → business logic
(`tasks` module) → storage (SQLite via `sqlite3` stdlib). Each
command is a single subcommand entry point.

## Components

```
┌────────────────────────────────────────┐
│ src/                                   │
│  __main__.py    (entry point)          │
│                                        │
│  commands/                             │
│   add.py        (FR-001, FR-006)       │
│   list_.py      (FR-002)               │
│   done.py       (FR-003, FR-007)       │
│                                        │
│  storage/                              │
│   sqlite.py     (FR-004, NFR-003)      │
│   schema.py     (table DDL, migration) │
│                                        │
│  tasks.py       (domain types: Task)   │
└────────────────────────────────────────┘
```

## Data Model

```sql
CREATE TABLE tasks (
    id          INTEGER PRIMARY KEY AUTOINCREMENT,
    title       TEXT    NOT NULL,
    created_at  TEXT    NOT NULL,           -- ISO-8601
    completed_at TEXT                       -- NULL = open
);
```

Each task: integer id, title, created timestamp, optional completed timestamp.

## Integrations

None. No HTTP calls, no third-party services.

## Technology Choices

See ADRs:
- `docs/adr/0001-language-and-stack.md` — Python 3.11
- `docs/adr/0002-storage-format.md` — SQLite via stdlib `sqlite3`
- `docs/adr/0003-cli-framework.md` — Click

## Security

- No network → no remote attack surface.
- Storage file: in `~/.todo-cli/tasks.db`, default permissions (user-only on
  Unix; relies on home dir ACLs on Windows).
- Input validation: title trimmed, max 200 chars, rejects empty after trim.
- No SQL string concatenation — all queries parameterized.
- No shell-out to external commands.

## Deployment

The CLI installs via `pip install`. No build step beyond Python wheel.

## Open Decisions

(none — all closed by `/architecture` session)
