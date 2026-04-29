# Contributing

Thanks for thinking about contributing. This is a small, focused project — we
prefer fewer, well-thought-out changes over many speculative ones.

## Before you open a PR

- **Check the README's "Why Not"** section. Some features are intentionally
  out of scope (plugin marketplace, AI/ML niche agents, etc.). Don't waste
  your time if your idea conflicts with the philosophy.
- **Open an issue first** for anything bigger than a typo. Use the
  appropriate template (bug, feature, or new agent proposal). This avoids
  building something that won't merge.

## Project structure

```
.claude/
  agents/          # 7 agent definitions (markdown)
  commands/        # 9 slash commands (markdown)
  docs/            # Collaboration / coordination / standards
  memory/          # Project learning categories
  settings.json    # Permissions
CLAUDE.md          # Per-session config (auto-loaded)
README.md
CHANGELOG.md       # Keep a Changelog format
SECURITY.md
install.{sh,ps1,bat}  # Cross-platform installers
scripts/validate.py   # Frontmatter linter
demo/                 # Asciinema cast + SVG + social preview
examples/             # Worked examples
.github/              # Issue / PR templates
```

The 7 agents are: **cto, researcher, qa, tech-lead, developer,
security-reviewer, devops**. The 9 commands are: `/start`, `/takeover`,
`/help`, `/feature`, `/quick-fix`, `/bug-fix`, `/security-review`,
`/release-check`, `/memory`. Adding a new one is fine — adding one that
overlaps an existing role is not.

## Adding or changing an agent

Agents live in `.claude/agents/<name>.md`. The format:

```markdown
---
name: agent-name
description: "When MUST this agent be used. PROACTIVE triggers."
tools: Read, Glob, Grep, Write, Edit, Bash
model: sonnet              # opus, sonnet, haiku, or inherit
---

You are the [Role]. Your job: [one sentence].

### Language Protocol

Detect the user's language and respond in it. Default: English.
[Domain-specific language notes — what stays English (code, etc.)]

### Responsibilities

- ...

### How You Work

1. ...
2. ...

### [Domain-specific sections]
- Performance targets, security checklist, quality bars, etc.

### Consult / Delegate

- For X → some-other-agent
- For Y → ...

### Definition of Done

- [ ] ...

### Output Format

\`\`\`
STATUS: COMPLETED | BLOCKED | NEEDS_INPUT
BLOCKER: [if any]
[domain-specific fields]
NEXT: [recommended step]
\`\`\`
```

### Boundaries

Every agent must declare what it **does** and what it **does not** do.
Overlap with other agents = confusion. Before adding, read the existing
agent's prompt and prove yours is non-redundant.

### Tier

- **Top, on-call** (Opus): cto — stack / architecture / breaking change / release sign-off
- **Flow** (Sonnet): researcher → qa → tech-lead → developer
- **On-call** (Sonnet, security-reviewer Opus): security-reviewer, devops — invoked by trigger only

If your new agent doesn't fit one of these and isn't a clear flow addition,
open a discussion before opening a PR — overlap is the most common reason
proposals get declined.

## Adding or changing a command

Commands live in `.claude/commands/<name>.md`. The format:

```markdown
---
description: "What it does and when it triggers."
allowed-tools: Read, Glob, Grep, Write, Edit
argument-hint: "[optional argument description]"
---

# /name

[Body — instructions Claude follows when this command runs.]

### Steps

1. ...
2. ...

### Rules

- ...

### Output

[Standard or command-specific output structure]
```

### Trigger description

The `description` field is critical — it's how Claude decides when to engage.
Use natural-language triggers:

> ✅ "Create a structured bug report. Triggers on 'there's a bug', 'it's broken',
>    'crash', 'X doesn't work', 'create bug report'."

> ❌ "Bug report tool"

## Validating your changes

```bash
python scripts/validate.py
```

This catches missing frontmatter fields, wrong model values, unknown tools.

If you change `examples/todo-cli/`:

```bash
cd examples/todo-cli
pytest
```

Should still be 13/13 passing.

## Commit messages

Plain prose, present tense, descriptive. No emoji prefix required.

✅ `Add /quick-fix command for lightweight changes`
✅ `Strengthen developer with stack detection`
❌ `feat: stuff`
❌ `🚀 added cool thing`

If your change is user-facing, **also update**:
- `CHANGELOG.md` under `[Unreleased]`
- README if installation / commands / agents changed

## PR review

The maintainer is solo. Expect 3–7 day response time. Reasons we'll
probably ask for changes:

- Adds dependency without justification
- Breaks the "single-file-or-shell-script install" promise
- Conflicts with the multilingual Language Protocol
- Adds an agent that overlaps an existing one
- Frontmatter linter fails

## Code of conduct

Be kind. Disagreement is fine; rudeness isn't. Hostility, harassment, or
discriminatory language gets your PRs closed and account blocked.
