# todo-cli

## Problem

Developers track tasks in scattered places: GitHub issues, sticky notes,
vague TODO comments in code. Quick personal task lists belong neither in
project trackers (too heavy) nor in plain notes (no structure).

## Target User

Developers who live in the terminal and want a 1-second-to-use task list
without leaving the shell. **Not** a team tool — single-user, local-only.

## Value Proposition

Compared to alternatives:
- **vs sticky notes**: structured, searchable, persists across reboots
- **vs `todo.txt` apps**: no syntax to learn, just `todo add "thing"`
- **vs full project trackers (Linear, Jira)**: zero setup, no auth, no sync
- **vs notes apps**: command-line, scriptable, scriptable from CI

## MVP Scope

### In
- Add a task with a short title
- List open tasks
- Mark a task done
- Persistent local storage (survives reboot)

### Out (deferred)
- Tags / categories
- Due dates
- Priority levels
- Sync across machines
- Sub-tasks
- Sharing / collaboration

## Success Criteria

- Add → list → complete cycle takes < 5 seconds total user input
- 0 dependencies beyond Python stdlib + Click
- Zero-config: works the moment it's installed

## Open Questions

(none — closed during /architecture)
