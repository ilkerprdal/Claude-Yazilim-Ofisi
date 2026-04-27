"""`todo done <id>` — story 003."""
from __future__ import annotations

import click

from src.storage.sqlite import open_db, complete_task


@click.command()
@click.argument("task_id", type=int)
def done(task_id: int) -> None:
    """Mark a task complete."""
    with open_db() as conn:
        result = complete_task(conn, task_id)
    if result is None:
        raise click.UsageError(f"No task with id {task_id}.")
    if result.completed_at is None:
        # shouldn't happen, but defensive
        raise click.UsageError(f"Failed to complete task {task_id}.")
    click.echo(f"Done [{result.id}] {result.title}")
