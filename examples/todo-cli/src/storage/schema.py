"""Database schema (idempotent)."""
from __future__ import annotations

import sqlite3


SCHEMA = """
CREATE TABLE IF NOT EXISTS tasks (
    id           INTEGER PRIMARY KEY AUTOINCREMENT,
    title        TEXT    NOT NULL,
    created_at   TEXT    NOT NULL,
    completed_at TEXT
);
"""


def init_schema(conn: sqlite3.Connection) -> None:
    """Create the tasks table if it doesn't exist."""
    conn.executescript(SCHEMA)
    conn.commit()
