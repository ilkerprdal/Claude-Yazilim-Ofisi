"""Test fixtures."""
from __future__ import annotations

from pathlib import Path

import pytest

from src.storage.sqlite import open_db


@pytest.fixture
def tmp_db(tmp_path: Path):
    """A fresh temp DB for each test."""
    db_path = tmp_path / "test.db"

    class DBHandle:
        def __init__(self, path: Path):
            self.path = path

        def open(self):
            return open_db(self.path)

    return DBHandle(db_path)
