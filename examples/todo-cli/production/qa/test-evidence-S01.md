# Test Evidence — Sprint S01

**Date**: 2026-04-19
**Recorded by**: qa-lead

## Automated Test Results

```
$ pytest -v
============================= test session starts =============================
platform win32 -- Python 3.11.9, pytest-9.0.2
collected 13 items

tests/unit/test_storage.py::test_add_task_returns_task_with_id PASSED    [  7%]
tests/unit/test_storage.py::test_add_persists_across_connections PASSED  [ 15%]
tests/unit/test_storage.py::test_list_returns_open_tasks_only_by_default PASSED [ 23%]
tests/unit/test_storage.py::test_list_with_include_done_returns_all PASSED [ 30%]
tests/unit/test_storage.py::test_list_empty_returns_empty_list PASSED    [ 38%]
tests/unit/test_storage.py::test_complete_unknown_id_returns_none PASSED [ 46%]
tests/unit/test_storage.py::test_complete_is_idempotent PASSED           [ 53%]
tests/unit/test_storage.py::test_completed_task_disappears_from_default_list PASSED [ 61%]
tests/unit/test_tasks.py::test_normalize_title_strips_whitespace PASSED  [ 69%]
tests/unit/test_tasks.py::test_normalize_title_rejects_empty PASSED      [ 76%]
tests/unit/test_tasks.py::test_normalize_title_rejects_whitespace_only PASSED [ 84%]
tests/unit/test_tasks.py::test_normalize_title_rejects_too_long PASSED   [ 92%]
tests/unit/test_tasks.py::test_normalize_title_accepts_max_length PASSED [100%]

============================= 13 passed in 0.08s ==============================
```

## Coverage Mapping

| Story | Acceptance Criteria | Test |
|-------|---------------------|------|
| 001 | task with id created | `test_add_task_returns_task_with_id` |
| 001 | persists across invocations | `test_add_persists_across_connections` |
| 001 | empty title rejected | `test_normalize_title_rejects_empty`, `_rejects_whitespace_only` |
| 001 | title length limit | `test_normalize_title_rejects_too_long`, `_accepts_max_length` |
| 001 | whitespace trimmed | `test_normalize_title_strips_whitespace` |
| 002 | open tasks only by default | `test_list_returns_open_tasks_only_by_default` |
| 002 | --all includes completed | `test_list_with_include_done_returns_all` |
| 002 | empty list message | `test_list_empty_returns_empty_list` |
| 003 | unknown id rejected | `test_complete_unknown_id_returns_none` |
| 003 | idempotent | `test_complete_is_idempotent` |
| 003 | completed disappears from list | `test_completed_task_disappears_from_default_list` |

## Smoke Test (manual)

```
$ python -m src add "buy milk"
Added [1] buy milk

$ python -m src add "write tests"
Added [2] write tests

$ python -m src list
[1] buy milk
[2] write tests

$ python -m src done 1
Done [1] buy milk

$ python -m src list
[2] write tests

$ python -m src list --all
[1] ̶buy milk̶ (done)
[2] write tests
```

## QA Lead Verdict

```
STATUS: COMPLETED
GATE: PASS
EVIDENCE_TYPE: UNIT + MANUAL
COVERAGE: 11/11 acceptance criteria covered
GAPS: none for v0.1 scope
WROTE: production/qa/test-evidence-S01.md
NEXT: Sprint can be marked complete, /retro
```
