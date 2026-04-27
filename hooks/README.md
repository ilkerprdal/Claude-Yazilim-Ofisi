# Hooks

Optional event handlers that run automatically when Software Office is installed
as a Claude Code plugin.

## Design philosophy

**Hooks here never block your work.** They only print hints when something
might be off. Every hook fails open — if its prerequisites aren't met (no
Python, no git, no test framework), it exits silently.

## Active hooks

### `post-edit-validate.sh`

**Triggers**: After `Write`, `Edit`, or `MultiEdit` tool calls.

**What it does**: If the project has a `.claude/agents/` or `.claude/commands/`
directory, runs `scripts/validate.py` against the frontmatter. If validation
finds problems, prints a warning to stderr.

**What it never does**: Block the tool call. Even on validation failure, it
exits 0.

**Skipped silently when**:
- Python isn't installed
- `scripts/validate.py` isn't present
- The project has no `.claude/agents/` or `.claude/commands/` directory

### `pre-bash-hint.sh`

**Triggers**: Before any `Bash` tool call.

**What it does**: If the command looks like `git push` and the project
contains a recognizable test framework manifest (`pyproject.toml`,
`package.json`, `Cargo.toml`, etc.), prints a friendly reminder to stderr.

**What it never does**: Block the push. Suppress errors. Mess with the
command.

**Skipped silently when**:
- The project isn't a git repo
- The command isn't a `git push`
- No test framework manifest is present

## Disabling hooks

If a hook misbehaves on your machine, disable it:

```bash
# In your project's settings (not the plugin):
# .claude/settings.json
{
  "disabledHooks": ["software-office"]
}
```

Or uninstall the plugin entirely:

```
/plugin uninstall claude-software-office
```

## Adding your own hooks

If you want to extend behavior, fork the plugin and edit `hooks/hooks.json`.
Follow the same defensive principles:

1. Always exit 0 (never block).
2. Check for prerequisites before doing anything.
3. Print hints to stderr, not stdout.
4. Read stdin event JSON cautiously — fall back gracefully if missing.

See [Claude Code's plugin reference](https://code.claude.com/docs/en/plugins-reference#hooks)
for the full event list.
