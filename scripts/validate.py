#!/usr/bin/env python3
"""
Validate frontmatter in .claude/agents/*.md and .claude/commands/*.md.

Checks:
- File starts with `---` and has a closing `---`
- Required fields present (name OR description, depending on file type)
- `tools` and `allowed-tools` values are comma-separated, no obvious typos
- `model` is one of: opus, sonnet, haiku, inherit (or omitted)
- Body is non-empty after frontmatter

Usage:
  python scripts/validate.py                # validate everything
  python scripts/validate.py .claude/agents # specific dir
  python scripts/validate.py --strict       # warnings become errors

Exit code:
  0 — all good (or only warnings without --strict)
  1 — errors found
"""
from __future__ import annotations

import sys
import re
from pathlib import Path

# Force UTF-8 output so Unicode markers don't crash on Windows cp1254 etc.
try:
    sys.stdout.reconfigure(encoding="utf-8")
    sys.stderr.reconfigure(encoding="utf-8")
except Exception:
    # Fallback: replace markers with ASCII if reconfigure fails
    pass

ROOT = Path(__file__).resolve().parent.parent
AGENT_DIR = ROOT / ".claude" / "agents"
COMMAND_DIR = ROOT / ".claude" / "commands"

KNOWN_MODELS = {"opus", "sonnet", "haiku", "inherit"}

# Heuristic list of valid tool names (extend as needed).
KNOWN_TOOLS = {
    "Read", "Write", "Edit", "MultiEdit", "Glob", "Grep", "Bash",
    "WebFetch", "WebSearch", "Task", "AskUserQuestion", "TodoWrite",
    "NotebookEdit",
}


class Issue:
    def __init__(self, path: Path, level: str, msg: str):
        self.path = path
        self.level = level  # "error" or "warn"
        self.msg = msg

    def __str__(self):
        try:
            rel = self.path.relative_to(ROOT) if self.path.is_relative_to(ROOT) else self.path
        except (ValueError, AttributeError):
            rel = self.path
        marker = "[ERROR]" if self.level == "error" else "[WARN] "
        return f"  {marker} {rel}: {self.msg}"


def parse_frontmatter(text: str) -> tuple[dict | None, str]:
    """Return (fields, body) or (None, text) if no frontmatter."""
    if not text.startswith("---\n") and not text.startswith("---\r\n"):
        return None, text
    rest = text.split("---", 2)
    if len(rest) < 3:
        return None, text
    raw = rest[1].strip("\n")
    body = rest[2].lstrip("\n")
    fields = {}
    for line in raw.splitlines():
        line = line.rstrip()
        if not line or line.lstrip().startswith("#"):
            continue
        if ":" not in line:
            continue
        key, _, value = line.partition(":")
        fields[key.strip()] = value.strip()
    return fields, body


def split_csv(value: str) -> list[str]:
    # strip surrounding quotes if any
    v = value.strip().strip('"').strip("'")
    if not v:
        return []
    return [t.strip() for t in v.split(",") if t.strip()]


def validate_frontmatter_file(path: Path, kind: str) -> list[Issue]:
    """kind: 'agent' or 'command'."""
    issues: list[Issue] = []
    text = path.read_text(encoding="utf-8")

    fields, body = parse_frontmatter(text)
    if fields is None:
        issues.append(Issue(path, "error", "missing or malformed YAML frontmatter (must start with `---`)"))
        return issues

    if not body.strip():
        issues.append(Issue(path, "error", "empty body after frontmatter"))

    # description is required for both
    if "description" not in fields or not fields["description"].strip():
        issues.append(Issue(path, "error", "missing `description` field"))

    if kind == "agent":
        if "name" not in fields or not fields["name"]:
            issues.append(Issue(path, "error", "missing `name` field"))
        else:
            stem = path.stem
            name_value = fields["name"].strip().strip('"').strip("'")
            if name_value != stem:
                issues.append(Issue(path, "warn", f"`name` ('{name_value}') doesn't match filename ('{stem}')"))

        # tools field (optional but if present, validate)
        if "tools" in fields:
            tools = split_csv(fields["tools"])
            unknown = [t for t in tools if t not in KNOWN_TOOLS]
            if unknown:
                issues.append(Issue(path, "warn", f"unknown tools: {unknown}"))

        # model field
        if "model" in fields:
            model = fields["model"].strip().strip('"').strip("'")
            if model and model not in KNOWN_MODELS:
                issues.append(Issue(path, "warn", f"unusual model value: '{model}' (expected one of {sorted(KNOWN_MODELS)})"))

    elif kind == "command":
        # commands shouldn't have a `name` field (filename is the command name)
        if "name" in fields:
            issues.append(Issue(path, "warn", "`name` field unexpected in command (filename is the command)"))

        if "allowed-tools" in fields:
            tools = split_csv(fields["allowed-tools"])
            unknown = [t for t in tools if t not in KNOWN_TOOLS]
            if unknown:
                issues.append(Issue(path, "warn", f"unknown tools in allowed-tools: {unknown}"))

    return issues


def validate_all(paths: list[Path], strict: bool = False) -> int:
    all_issues: list[Issue] = []

    for d in paths:
        if not d.exists():
            print(f"skipping (missing): {d}")
            continue
        kind = "agent" if d.name == "agents" else "command" if d.name == "commands" else None
        if kind is None:
            print(f"skipping (unknown dir): {d}")
            continue
        for f in sorted(d.glob("*.md")):
            issues = validate_frontmatter_file(f, kind)
            all_issues.extend(issues)

    errors = [i for i in all_issues if i.level == "error"]
    warns = [i for i in all_issues if i.level == "warn"]

    if errors:
        print(f"\nErrors ({len(errors)}):")
        for i in errors:
            print(i)
    if warns:
        print(f"\nWarnings ({len(warns)}):")
        for i in warns:
            print(i)

    if not errors and not warns:
        print("All files OK.")

    if errors:
        return 1
    if strict and warns:
        return 1
    return 0


def main():
    args = sys.argv[1:]
    strict = False
    if "--strict" in args:
        strict = True
        args.remove("--strict")

    if args:
        paths = [Path(p) for p in args]
    else:
        paths = [AGENT_DIR, COMMAND_DIR]

    sys.exit(validate_all(paths, strict=strict))


if __name__ == "__main__":
    main()
