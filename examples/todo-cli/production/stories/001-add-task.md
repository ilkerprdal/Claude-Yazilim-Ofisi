# [001] Add a task

**Type**: Backend (CLI command + storage)
**Estimate**: S

## Goal

User can add a single task to the persistent store via `todo add "title"`.

## Acceptance Criteria

- [x] `todo add "buy milk"` exits 0 and prints the new task ID
- [x] After adding, the task is visible in `todo list`
- [x] Tasks survive process exit (next invocation sees them)
- [x] Empty title (`todo add ""`) exits non-zero with a clear error
- [x] Title trimmed of leading/trailing whitespace before storage
- [x] Title longer than 200 chars rejected with clear error

## Technical Notes

- Related ADR: `0002-storage-format.md` (SQLite), `0003-cli-framework.md` (Click)
- Touches: `src/commands/add.py`, `src/storage/sqlite.py`, `src/tasks.py`
- Dependency: none (first story in the sprint)
- Maps to: FR-001, FR-006, FR-004

## Test Evidence

- Unit test: `tests/unit/test_add.py` (5 cases, all PASS)
- Manual smoke: documented in `production/qa/smoke-S01.md`

## Status

Done

## Resolution Notes

- Files: `src/commands/add.py`, `src/storage/sqlite.py`, `src/tasks.py`,
  `src/storage/schema.py`
- Test result: 5/5 PASS
- Acceptance: 6/6 met
- Security: input validation present, parameterized queries, no PII
- Performance: cold add < 100ms (well under NFR-001)
- DoD: 8/8
