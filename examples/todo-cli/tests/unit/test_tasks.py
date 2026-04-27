"""Tests for src.tasks."""
import pytest

from src.tasks import normalize_title, MAX_TITLE_LEN


def test_normalize_title_strips_whitespace():
    assert normalize_title("  buy milk  ") == "buy milk"


def test_normalize_title_rejects_empty():
    with pytest.raises(ValueError, match="empty"):
        normalize_title("")


def test_normalize_title_rejects_whitespace_only():
    with pytest.raises(ValueError, match="empty"):
        normalize_title("   ")


def test_normalize_title_rejects_too_long():
    too_long = "x" * (MAX_TITLE_LEN + 1)
    with pytest.raises(ValueError, match="too long"):
        normalize_title(too_long)


def test_normalize_title_accepts_max_length():
    at_max = "x" * MAX_TITLE_LEN
    assert normalize_title(at_max) == at_max
