"""`todo add "title"` — story 001."""
from __future__ import annotations

import click

from src.storage.sqlite import open_db, add_task
from src.tasks import normalize_title


@click.command()
@click.argument("title")
def add(title: str) -> None:
    """Add a task with TITLE."""
    try:
        clean = normalize_title(title)
    except ValueError as e:
        raise click.UsageError(str(e))
    with open_db() as conn:
        task = add_task(conn, clean)
    click.echo(f"Added [{task.id}] {task.title}")
