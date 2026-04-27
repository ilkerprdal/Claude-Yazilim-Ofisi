"""Domain types."""
from __future__ import annotations

from dataclasses import dataclass
from datetime import datetime, timezone


MAX_TITLE_LEN = 200


@dataclass(frozen=True)
class Task:
    """An immutable task record."""

    id: int
    title: str
    created_at: str           # ISO-8601 UTC
    completed_at: str | None  # ISO-8601 UTC or None

    @property
    def is_open(self) -> bool:
        return self.completed_at is None


def normalize_title(raw: str) -> str:
    """Trim whitespace, raise ValueError if empty or too long."""
    title = raw.strip()
    if not title:
        raise ValueError("title cannot be empty")
    if len(title) > MAX_TITLE_LEN:
        raise ValueError(f"title too long (max {MAX_TITLE_LEN} chars)")
    return title


def now_iso() -> str:
    """Current UTC time in ISO-8601, second precision."""
    return datetime.now(timezone.utc).replace(microsecond=0).isoformat()
