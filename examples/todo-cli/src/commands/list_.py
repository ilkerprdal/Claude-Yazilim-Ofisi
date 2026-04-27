"""`todo list` — story 002."""
from __future__ import annotations

import click

from src.storage.sqlite import open_db, list_tasks


@click.command()
@click.option("--all", "show_all", is_flag=True, help="Include completed tasks.")
def list_(show_all: bool) -> None:
    """List open tasks (or all with --all)."""
    with open_db() as conn:
        tasks = list_tasks(conn, include_done=show_all)
    if not tasks:
        click.echo("No open tasks.")
        return
    for t in tasks:
        if t.completed_at is not None:
            click.echo(f"[{t.id}] ̶{t.title}̶ (done)")
        else:
            click.echo(f"[{t.id}] {t.title}")
