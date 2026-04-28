#!/usr/bin/env bash
# post-edit-validate.sh
#
# Runs after Write/Edit/MultiEdit. WARN ONLY — never blocks.
#
# Performance: early-exits if the edit isn't under .claude/agents or
# .claude/commands. Validator only checks frontmatter in those dirs anyway,
# so running it after every src/ edit was wasted CPU.
#
# Defensive design:
#   - No working Python? Skip silently.
#     (Important: Windows Store ships a python3 stub that prints
#      "Python was not found" — we detect and skip it.)
#   - No validate.py? Skip silently.
#   - Validation fails? Print warning to stderr, exit 0.

set -u

# Read tool event JSON from stdin (best-effort; ignore if missing)
EVENT_JSON=""
if [ ! -t 0 ]; then
    EVENT_JSON="$(cat 2>/dev/null || true)"
fi

# Fast path: skip if the edit clearly isn't a framework file.
# Check for .claude/agents or .claude/commands in the event payload.
# If we can't tell (weird payload, empty stdin), fall through and let the
# validator decide — it's still cheap when there's nothing to validate.
if [ -n "$EVENT_JSON" ]; then
    if ! echo "$EVENT_JSON" | grep -qE '\.claude[/\\](agents|commands)[/\\]'; then
        # Edit isn't to an agent/command file — nothing for us to do.
        exit 0
    fi
fi

# Find a working Python — verify with --version, not just `command -v`,
# because Windows Store ships a stub for `python3`.
PYTHON=""
for candidate in python3 python; do
    if command -v "$candidate" >/dev/null 2>&1; then
        if "$candidate" --version >/dev/null 2>&1; then
            PYTHON="$candidate"
            break
        fi
    fi
done
[ -z "$PYTHON" ] && exit 0

# Locate validator. Prefer plugin-bundled, fall back to project-local.
VALIDATOR=""
if [ -n "${CLAUDE_PLUGIN_ROOT:-}" ] && [ -f "${CLAUDE_PLUGIN_ROOT}/scripts/validate.py" ]; then
    VALIDATOR="${CLAUDE_PLUGIN_ROOT}/scripts/validate.py"
elif [ -f "scripts/validate.py" ]; then
    VALIDATOR="scripts/validate.py"
else
    exit 0
fi

# Only run if there's something to validate
if [ ! -d ".claude/agents" ] && [ ! -d ".claude/commands" ]; then
    exit 0
fi

# Run validator
OUTPUT="$("$PYTHON" "$VALIDATOR" 2>&1)"
STATUS=$?

if [ "$STATUS" -ne 0 ]; then
    {
        echo "[software-office] frontmatter validator reports issues:"
        printf '%s\n' "$OUTPUT" | sed 's/^/  /'
        echo "[software-office] (this is a hint, not a block)"
    } >&2
fi

# Always succeed
exit 0
