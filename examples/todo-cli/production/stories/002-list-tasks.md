# [002] List tasks

**Type**: Backend (CLI command + storage read)
**Estimate**: S

## Goal

User can see all open tasks via `todo list`, formatted for readability.

## Acceptance Criteria

- [x] `todo list` prints all open (uncompleted) tasks
- [x] Each line: `[id] title`
- [x] Empty list: prints "No open tasks." (not blank)
- [x] Completed tasks excluded by default
- [x] `--all` flag includes completed tasks (with strike-through marker)

## Technical Notes

- Related ADR: `0002-storage-format.md`
- Touches: `src/commands/list_.py`, `src/storage/sqlite.py`
- Depends on: 001 (storage layer must exist)
- Maps to: FR-002

## Test Evidence

- Unit test: `tests/unit/test_list.py`
- Manual smoke: included in `production/qa/smoke-S01.md`

## Status

Done
