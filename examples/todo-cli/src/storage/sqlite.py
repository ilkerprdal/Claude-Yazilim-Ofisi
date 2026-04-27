"""SQLite-backed task storage.

Connection lifecycle: each command opens a fresh connection, runs its
operation in a transaction, and closes. SQLite handles atomicity (NFR-003).
"""
from __future__ import annotations

import os
import sqlite3
from contextlib import contextmanager
from pathlib import Path
from typing import Iterator

from src.storage.schema import init_schema
from src.tasks import Task, now_iso


def default_db_path() -> Path:
    home = Path(os.path.expanduser("~"))
    return home / ".todo-cli" / "tasks.db"


@contextmanager
def open_db(path: Path | None = None) -> Iterator[sqlite3.Connection]:
    """Open the DB, ensure schema, yield a connection."""
    db_path = path or default_db_path()
    db_path.parent.mkdir(parents=True, exist_ok=True)
    conn = sqlite3.connect(db_path)
    conn.row_factory = sqlite3.Row
    try:
        init_schema(conn)
        yield conn
    finally:
        conn.close()


def add_task(conn: sqlite3.Connection, title: str) -> Task:
    """Insert and return the new task."""
    created_at = now_iso()
    cursor = conn.execute(
        "INSERT INTO tasks (title, created_at) VALUES (?, ?)",
        (title, created_at),
    )
    conn.commit()
    return Task(
        id=cursor.lastrowid or 0,
        title=title,
        created_at=created_at,
        completed_at=None,
    )


def list_tasks(conn: sqlite3.Connection, *, include_done: bool = False) -> list[Task]:
    """Return tasks, ordered by id ascending."""
    if include_done:
        rows = conn.execute("SELECT * FROM tasks ORDER BY id ASC").fetchall()
    else:
        rows = conn.execute(
            "SELECT * FROM tasks WHERE completed_at IS NULL ORDER BY id ASC"
        ).fetchall()
    return [_row_to_task(r) for r in rows]


def find_task(conn: sqlite3.Connection, task_id: int) -> Task | None:
    row = conn.execute("SELECT * FROM tasks WHERE id = ?", (task_id,)).fetchone()
    return _row_to_task(row) if row else None


def complete_task(conn: sqlite3.Connection, task_id: int) -> Task | None:
    """Mark a task complete. Idempotent — re-completing returns existing
    task without changing completed_at."""
    existing = find_task(conn, task_id)
    if existing is None:
        return None
    if existing.completed_at is not None:
        return existing
    completed_at = now_iso()
    conn.execute(
        "UPDATE tasks SET completed_at = ? WHERE id = ?",
        (completed_at, task_id),
    )
    conn.commit()
    return Task(
        id=existing.id,
        title=existing.title,
        created_at=existing.created_at,
        completed_at=completed_at,
    )


def _row_to_task(row: sqlite3.Row) -> Task:
    return Task(
        id=row["id"],
        title=row["title"],
        created_at=row["created_at"],
        completed_at=row["completed_at"],
    )
