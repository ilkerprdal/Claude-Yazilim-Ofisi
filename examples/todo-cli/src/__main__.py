"""Entry point for `python -m todo_cli`."""
from __future__ import annotations

import click

from src.commands.add import add
from src.commands.list_ import list_
from src.commands.done import done


@click.group()
def cli() -> None:
    """A 1-second-to-use todo list for the terminal."""


cli.add_command(add)
cli.add_command(list_, name="list")
cli.add_command(done)


if __name__ == "__main__":
    cli()
