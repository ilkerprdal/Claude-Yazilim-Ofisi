"""Tests for storage layer — covers stories 001, 002, 003."""
from src.storage.sqlite import add_task, list_tasks, complete_task, find_task


def test_add_task_returns_task_with_id(tmp_db):
    with tmp_db.open() as conn:
        task = add_task(conn, "buy milk")
    assert task.id > 0
    assert task.title == "buy milk"
    assert task.completed_at is None


def test_add_persists_across_connections(tmp_db):
    with tmp_db.open() as conn:
        added = add_task(conn, "buy milk")
    # Reopen
    with tmp_db.open() as conn:
        found = find_task(conn, added.id)
    assert found is not None
    assert found.title == "buy milk"


def test_list_returns_open_tasks_only_by_default(tmp_db):
    with tmp_db.open() as conn:
        a = add_task(conn, "open one")
        b = add_task(conn, "to be done")
        complete_task(conn, b.id)
    with tmp_db.open() as conn:
        tasks = list_tasks(conn)
    assert len(tasks) == 1
    assert tasks[0].title == "open one"


def test_list_with_include_done_returns_all(tmp_db):
    with tmp_db.open() as conn:
        a = add_task(conn, "first")
        b = add_task(conn, "second")
        complete_task(conn, b.id)
    with tmp_db.open() as conn:
        tasks = list_tasks(conn, include_done=True)
    assert len(tasks) == 2


def test_list_empty_returns_empty_list(tmp_db):
    with tmp_db.open() as conn:
        tasks = list_tasks(conn)
    assert tasks == []


def test_complete_unknown_id_returns_none(tmp_db):
    with tmp_db.open() as conn:
        assert complete_task(conn, 9999) is None


def test_complete_is_idempotent(tmp_db):
    with tmp_db.open() as conn:
        added = add_task(conn, "task")
        first = complete_task(conn, added.id)
        second = complete_task(conn, added.id)
    assert first is not None and first.completed_at is not None
    assert second is not None
    # Re-completing returns the same completed_at (no clobber)
    assert second.completed_at == first.completed_at


def test_completed_task_disappears_from_default_list(tmp_db):
    with tmp_db.open() as conn:
        added = add_task(conn, "to be done")
        complete_task(conn, added.id)
    with tmp_db.open() as conn:
        tasks = list_tasks(conn)
    assert tasks == []
