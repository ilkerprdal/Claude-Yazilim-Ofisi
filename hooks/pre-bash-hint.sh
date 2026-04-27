#!/usr/bin/env bash
# pre-bash-hint.sh
#
# Runs before every Bash tool call. If the command looks like `git push`,
# remind the user to run tests if they haven't recently. HINT ONLY —
# never blocks the push.
#
# Defensive design:
#   - No git in project? Skip silently.
#   - Hook errors out? Don't propagate (always exit 0).
#   - Hint goes to stderr so it doesn't pollute the captured tool output.

set -u

# Hook event arrives as JSON on stdin: { "tool": "Bash", "params": {"command": "..."} ... }
EVENT_JSON="$(cat 2>/dev/null || true)"

# Guard: no git in this project? skip
[ -d .git ] || exit 0

# Extract the command field. Try jq first, fall back to grep.
COMMAND=""
if command -v jq >/dev/null 2>&1; then
    COMMAND="$(printf '%s' "$EVENT_JSON" | jq -r '.tool_input.command // .params.command // empty' 2>/dev/null || true)"
fi
if [ -z "$COMMAND" ]; then
    # Fallback: grep the JSON
    COMMAND="$(printf '%s' "$EVENT_JSON" | grep -oE '"command"[[:space:]]*:[[:space:]]*"[^"]*"' | head -1 | sed -E 's/.*"command"[[:space:]]*:[[:space:]]*"([^"]*)".*/\1/' || true)"
fi

# Only react to git push commands
case "$COMMAND" in
    *"git push"*)
        # Detect if there's a test framework — if not, no point hinting
        TESTS_PRESENT=0
        for marker in pyproject.toml setup.cfg setup.py package.json Cargo.toml go.mod pom.xml build.gradle Gemfile composer.json; do
            if [ -f "$marker" ]; then
                TESTS_PRESENT=1
                break
            fi
        done

        if [ "$TESTS_PRESENT" = "1" ]; then
            {
                echo "[software-office] hint: about to git push — did you run tests?"
                echo "[software-office] (hint only — not blocking)"
            } >&2
        fi
        ;;
esac

# Always succeed
exit 0
