---
description: "Take over an existing project — read context.md, .cursorrules, and other AI memory files; convert them into .claude/memory/; summarize project state. Triggers on 'take over this project', 'import context', 'absorb prior notes', 'devral'."
allowed-tools: Read, Glob, Grep, Write, Edit, AskUserQuestion
argument-hint: "[optional: explicit path to a context file]"
---

# /takeover

Read context files left by previous AI sessions (Claude, Cursor, Copilot,
Windsurf, etc.), absorb into our system.

### Purpose

When installing Software Office into an existing project, **don't lose prior
context**. Old notes get converted into `.claude/memory/` so agents work with
this knowledge.

### Steps

#### 1. Scan Context Sources

Look for these files in order (list what you find):

**General context files**:
- `context.md`, `CONTEXT.md`
- `MEMORY.md`, `NOTES.md`, `AGENTS.md`
- `docs/CONTEXT.md`, `docs/STATE.md`, `docs/MEMORY.md`
- `STATE.md`, `PROJECT.md`

**AI tool rules**:
- `CLAUDE.md` (if present — don't clash with ours!)
- `.cursorrules`, `.cursor/rules/*.mdc`
- `.windsurfrules`, `.windsurf/rules/*.md`
- `.github/copilot-instructions.md`
- `.aider.conf.yml`, `.aiderignore`
- `.continue/config.json`, `.continuerules`

**Project meta**:
- `README.md`
- `ARCHITECTURE.md`, `DESIGN.md`
- `CHANGELOG.md` (last 20 entries)
- `TODO.md`, `ROADMAP.md`

List findings:
```
Found:
✓ context.md (1240 lines)
✓ .cursorrules (45 lines)
✓ docs/ARCHITECTURE.md (320 lines)
✓ TODO.md (78 lines)
✗ CLAUDE.md (none — fine)
```

#### 2. Conflict Check

If `CLAUDE.md` already exists in the project:
- Don't overwrite — merge
- Ask user: "Back up existing CLAUDE.md as `CLAUDE.legacy.md` and merge with ours?"

#### 3. Content Classification

Classify all content into these categories (show user, validate):

| Category | Target Memory File |
|----------|--------------------|
| Tech preferences (libs, patterns, architecture) | `.claude/memory/technical.md` |
| Anti-patterns / things to avoid | `.claude/memory/avoid.md` |
| Process rules (PR size, naming, etc.) | `.claude/memory/process.md` |
| Domain terms | `.claude/memory/domain.md` |
| Tools / commands / CLI configs | `.claude/memory/tools.md` |
| Completed work summary | `production/session-state/active.md` |
| Open tasks / TODOs | `production/backlog.md` |

#### 4. Generate Project State Summary

Write **Takeover Summary** into `production/session-state/active.md`:

```markdown
# Takeover Summary — [yyyy-mm-dd]

## Prior Work
- What area was being worked on?
- Which files have been touched (last 30 git log)?
- What features are complete?

## Open Work
- [From TODO.md, context]

## Current State
- Active branch: [git branch]
- Last commit: [git log -1]
- Open branches: [git branch | wc -l]

## Risks / Watch Out For
- [Warnings from prior notes]

## Source Files
- context.md, .cursorrules, docs/ARCHITECTURE.md (backed up at: `.takeover-backup/`)
```

#### 5. Back Up Originals

Don't delete anything — create `.takeover-backup/` and **copy** original
context files there (not move). User can keep or delete.

```
.takeover-backup/
├── context.md
├── .cursorrules.txt
├── docs-ARCHITECTURE.md
└── README.md (takeover report)
```

#### 6. Route User

After takeover:
- "Added N learnings to memory"
- "Project state ready in active.md"
- "Run `/help` or `/start` for next steps"

### Rules

- **Never delete** — source files copied to `.takeover-backup/`
- **Never overwrite** — clashes saved as `.legacy.md`
- **Decisions to user** — every classification needs approval
- **Translate, don't blindly copy** — if memory is in user's language preference,
  summarize and translate as you import

### Output

```
STATUS: COMPLETED | NEEDS_INPUT
SOURCES_FOUND: [files found]
MEMORY_NOTES_ADDED: [counts per category]
ACTIVE_MD_UPDATED: YES | NO
BACKUP_LOCATION: .takeover-backup/
CONFLICTS: [if any, resolution]
NEXT: /start or /help
```
