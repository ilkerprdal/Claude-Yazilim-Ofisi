#!/usr/bin/env bash
# Software Office installer (macOS / Linux / Git Bash on Windows)
#
# Usage:
#   curl -fsSL https://raw.githubusercontent.com/ilkerprdal/Claude-Software-Office/main/install.sh | bash
#   curl -fsSL https://raw.githubusercontent.com/ilkerprdal/Claude-Software-Office/main/install.sh | bash -s -- /path/to/project
#   bash install.sh                 # installs into current directory
#   bash install.sh /path/to/proj   # installs into specified directory
#
# Env:
#   SO_REF=main          # git ref/tag to install (default: main)
#   SO_YES=1             # skip confirmation
#   SO_NO_BACKUP=1       # don't back up existing CLAUDE.md

set -euo pipefail

REPO="ilkerprdal/Claude-Software-Office"
REF="${SO_REF:-main}"
TARGET="${1:-$PWD}"

# Colors (only if stdout is a TTY)
if [ -t 1 ]; then
    BLUE='\033[0;36m'; GREEN='\033[0;32m'; YELLOW='\033[0;33m'; RED='\033[0;31m'; NC='\033[0m'
else
    BLUE=''; GREEN=''; YELLOW=''; RED=''; NC=''
fi

log()    { printf "%b%s%b\n" "$BLUE" "$1" "$NC"; }
ok()     { printf "%b✓ %s%b\n" "$GREEN" "$1" "$NC"; }
warn()   { printf "%b! %s%b\n" "$YELLOW" "$1" "$NC"; }
die()    { printf "%b✗ %s%b\n" "$RED" "$1" "$NC" >&2; exit 1; }

echo
log "Software Office installer"
log "Target:  $TARGET"
log "Source:  github.com/$REPO@$REF"
echo

[ -d "$TARGET" ] || die "Target does not exist: $TARGET"

# Confirm
if [ "${SO_YES:-0}" != "1" ] && [ -t 0 ]; then
    read -r -p "Install into '$TARGET'? (y/n) " confirm
    case "$confirm" in
        y|Y) ;;
        *) warn "Cancelled."; exit 0;;
    esac
fi

# Download tarball
TMPDIR="$(mktemp -d)"
trap 'rm -rf "$TMPDIR"' EXIT

URL="https://codeload.github.com/$REPO/tar.gz/refs/heads/$REF"
log "Downloading $URL ..."

if command -v curl >/dev/null 2>&1; then
    curl -fsSL "$URL" -o "$TMPDIR/source.tar.gz"
elif command -v wget >/dev/null 2>&1; then
    wget -q "$URL" -O "$TMPDIR/source.tar.gz"
else
    die "Need 'curl' or 'wget'."
fi

mkdir -p "$TMPDIR/source"
tar xzf "$TMPDIR/source.tar.gz" -C "$TMPDIR/source" --strip-components=1
ok "Downloaded"

# Copy files
SRC="$TMPDIR/source"

# 1. .claude/ (overwrite — framework files)
mkdir -p "$TARGET/.claude"
cp -R "$SRC/.claude/." "$TARGET/.claude/"
ok ".claude/  (agents, commands, docs, memory, settings)"

# 2. CLAUDE.md (preserve existing — back up first)
if [ -f "$TARGET/CLAUDE.md" ] && [ "${SO_NO_BACKUP:-0}" != "1" ]; then
    cp "$TARGET/CLAUDE.md" "$TARGET/CLAUDE.legacy.md"
    warn "Existing CLAUDE.md backed up as CLAUDE.legacy.md"
fi
cp "$SRC/CLAUDE.md" "$TARGET/CLAUDE.md"
ok "CLAUDE.md"

# 3. .gitignore (merge — append entries that aren't already there)
if [ -f "$TARGET/.gitignore" ]; then
    while IFS= read -r line; do
        case "$line" in
            ''|'#'*) continue;;
        esac
        grep -qxF -- "$line" "$TARGET/.gitignore" || echo "$line" >> "$TARGET/.gitignore"
    done < "$SRC/.gitignore"
    ok ".gitignore  (merged)"
else
    cp "$SRC/.gitignore" "$TARGET/.gitignore"
    ok ".gitignore"
fi

# 4. production/ scaffold (only if missing)
if [ ! -d "$TARGET/production" ]; then
    mkdir -p "$TARGET/production/session-state" "$TARGET/production/stories" "$TARGET/production/sprints" "$TARGET/production/retros" "$TARGET/production/qa/bugs"
    [ -f "$SRC/production/session-state/active.md" ] && cp "$SRC/production/session-state/active.md" "$TARGET/production/session-state/"
    [ -f "$SRC/production/backlog.md" ] && cp "$SRC/production/backlog.md" "$TARGET/production/"
    ok "production/  (sprints, retros, qa, session-state)"
else
    warn "production/ exists — left alone"
fi

echo
ok "Installation complete."
echo
log "Next steps:"
echo "  cd \"$TARGET\""
echo "  claude"
echo "  /takeover    # if there are prior AI context files (context.md, .cursorrules, etc.)"
echo "  /start       # otherwise"
echo
echo "Agents auto-detect your language."
