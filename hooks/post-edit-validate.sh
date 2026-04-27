#!/usr/bin/env bash
# post-edit-validate.sh
#
# Runs after Write/Edit/MultiEdit. If the project is a Software Office
# install, validate frontmatter. WARN ONLY — never blocks.
#
# Defensive design:
#   - No working Python? Skip silently.
#     (Important: Windows Store ships a python3 stub that prints
#      "Python was not found" — we detect and skip it.)
#   - No validate.py? Skip silently.
#   - Validation fails? Print warning to stderr, exit 0.

set -u

# Read but ignore stdin
cat >/dev/null 2>&1 || true

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
