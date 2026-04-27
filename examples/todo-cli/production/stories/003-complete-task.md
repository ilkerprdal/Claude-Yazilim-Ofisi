# [003] Mark task done

**Type**: Backend (CLI command + storage update)
**Estimate**: S

## Goal

User marks a task complete via `todo done <id>`. Completed tasks no longer
show in default `list` output.

## Acceptance Criteria

- [x] `todo done <id>` marks the task with `completed_at = now()`
- [x] Subsequent `todo list` no longer shows the task
- [x] `todo list --all` shows it as completed
- [x] Unknown ID: clear error, exit non-zero
- [x] Already-completed task: idempotent — exits 0 with "already done" notice
- [x] Empty / non-numeric ID: clear error

## Technical Notes

- Related ADR: `0002-storage-format.md`
- Touches: `src/commands/done.py`, `src/storage/sqlite.py`
- Depends on: 001 (storage), 002 (list command for verification)
- Maps to: FR-003, FR-007

## Test Evidence

- Unit test: `tests/unit/test_done.py`

## Status

Done
