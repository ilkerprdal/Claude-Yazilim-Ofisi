# Software Office

[![CI](https://github.com/ilkerprdal/Claude-Software-Office/actions/workflows/ci.yml/badge.svg)](https://github.com/ilkerprdal/Claude-Software-Office/actions/workflows/ci.yml)
[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](LICENSE)
[![Release](https://img.shields.io/github/v/release/ilkerprdal/Claude-Software-Office)](https://github.com/ilkerprdal/Claude-Software-Office/releases)
[![Validator](https://img.shields.io/badge/frontmatter-validated-brightgreen)](scripts/validate.py)
[![Example tests](https://img.shields.io/badge/example-13%2F13_passing-brightgreen)](examples/todo-cli/tests/)
![Agents](https://img.shields.io/badge/agents-11-blueviolet)
![Commands](https://img.shields.io/badge/commands-22-blue)

Turn your Claude Code session into a small, organized software office.
**11 agents. 22 slash commands. Brownfield-friendly. Scale-adaptive.**

🇹🇷 **Türkçe**: [README.tr.md](README.tr.md)

> **Status: early preview** (v0.1.x). Verified locally on the maintainer's
> machine and through the included example. APIs (agent names, command
> behavior, output formats) may change before 1.0. Community feedback wanted.
>
> Inspired by Claude Code Game Studios and the broader Agile-agent ecosystem
> (BMAD-METHOD and others). Deliberately curated and smaller than those.

## ▶ Demo

![Software Office workflow](demo/workflow.svg)

A 30-second walk-through: `/start` → `/idea` → `/architecture` →
`/develop-story` → `/code-review`. The team picks the right agent at each
step, applies quality bars (security/performance/tests), and lets you
approve every change.

---

## Table of Contents

1. [What It Does](#what-it-does)
2. [Who Is This For](#who-is-this-for)
3. [Differentiators](#differentiators)
4. [Installation](#installation)
5. [How It Works](#how-it-works)
6. [The Team](#the-team)
7. [Slash Commands](#slash-commands)
8. [A Typical Workflow](#a-typical-workflow)
9. [Folder Layout](#folder-layout)
10. [Collaboration Protocol](#collaboration-protocol)
11. [Language Support](#language-support)
12. [Customization](#customization)

---

## What It Does

A single Claude session is powerful but unstructured. Nobody asks "do we
really need this?", nobody enforces code review, nobody catches when you
skip tests.

**Software Office** gives Claude a small team structure:

- **Decision makers** (Directors): vision and technical quality
- **Implementers** (Leads): code structure, UX, quality
- **Doers** (Specialists): backend, frontend, devops code

You still make every decision — but inside a team that asks the right
questions, knows its boundaries, and consults each other.

---

## Who Is This For

### ✅ A good fit if you are...
- A **solo developer** or **small team (2–5)** wanting just enough Agile discipline
- Working on a **small-to-mid size project** (~500–10,000 LOC) in a **mainstream stack**
  (web, REST/GraphQL API, CLI, library) that will live ≥ 2 months
- Joining a **brownfield project** — existing code, possibly with prior AI assistant
  context (Cursor, Copilot, Aider) — `/takeover` brings it forward
- Building **end-to-end with a single AI session** as your team

### ❌ Probably the wrong tool if you are...
- Writing a **one-shot script** (< 100 LOC) — direct Claude Code is faster
- In a **hackathon / time-boxed sprint** — process overhead doesn't pay off
- Part of a **20+ person org** with established Jira / ADRs / retros — it will clash
- Doing **bleeding-edge AI/ML research**, **embedded firmware**, **hardware drivers**,
  **blockchain protocol design** — agent domain knowledge is general-purpose
- Just want to **chat about code** — slash-command overhead is overkill for Q&A
- Need **enterprise multi-team coordination** with 50+ specialized agents → look at
  [BMAD-METHOD](https://github.com/bmad-code-org/BMAD-METHOD)

### When to use what

| If you... | Use |
|---|---|
| Want a single conversation, no structure | Direct Claude Code |
| Want lightweight Agile, solo / small team | **Software Office** |
| Need 50+ agents, enterprise greenfield | BMAD-METHOD |
| Have an existing project with prior AI context | **Software Office** (`/takeover`) |
| Want change-size-aware process (one-liner ↔ feature ↔ sprint) | **Software Office** (`/quick-fix`, `/feature`, `/sprint-plan`) |
| Want pair-programming chat, no ceremony | Direct Claude Code |

---

## Differentiators

What this project deliberately does differently from larger Agile-agent frameworks:

### Brownfield-first
- **`/takeover`** imports prior AI context (`.cursorrules`, `.windsurfrules`,
  `context.md`, generic project notes), backs it up, and distills it into
  the memory layer. You don't start from zero.
- Existing `CLAUDE.md` is preserved as `CLAUDE.legacy.md` — nothing overwritten silently.
- `.gitignore` is **merged**, not replaced.

### Scale-adaptive workflow
Process matches the change size. Three explicit tiers:

| Change | Command | Skips |
|---|---|---|
| < 50 LOC, no design impact | `/quick-fix` | story, sprint, retro, full review |
| 50–500 LOC, single feature | `/feature` | sprint planning, retro |
| > 500 LOC, multi-story | `/sprint-plan` + `/develop-story` | nothing |

No forced ceremony for trivial fixes.

### Defensive infrastructure
- **Hooks fail open** — missing Python, missing test framework, missing git
  → silent no-op. Hooks never block your work.
- **Cross-platform installers** (bash + PowerShell + bat wrapper) — no Node/npm dependency.
- **Three install paths**: plugin, one-liner, manual. Pick what works for your setup.

### Explicit boundaries
- **Anti-personas listed** — README tells you when *not* to use this (above).
- **Vertical delegation rules** — Director → Lead → Specialist, no shortcuts.
- **Memory layer** (`.claude/memory/`) — accumulated lessons across sessions, 5 categories.

### Honest scope
- **Single-maintainer project** — bus factor risk acknowledged.
- **Verified vs. designed-for** distinction in multilingual claim (see below).
- **Early preview status** (v0.1.x) — APIs may change.

---

## Installation

Three ways to install — pick the one that fits.

### A. Plugin install (recommended for Claude Code 2.x)

In a Claude Code session:

```
/plugin marketplace add ilkerprdal/Claude-Software-Office
/plugin install claude-software-office@claude-software-office-marketplace
```

This wires up agents, commands, and hooks as a Claude Code plugin —
auto-update via `/plugin update`, scoped to user or project as you choose.

### B. One-liner (for any project, no plugin support needed)

**macOS / Linux / Git Bash on Windows:**
```bash
curl -fsSL https://raw.githubusercontent.com/ilkerprdal/Claude-Software-Office/main/install.sh | bash
```

**Windows PowerShell:**
```powershell
irm https://raw.githubusercontent.com/ilkerprdal/Claude-Software-Office/main/install.ps1 | iex
```

Run from inside your project's root folder. The script downloads the latest
release, installs `.claude/`, `CLAUDE.md`, `.gitignore`, and a `production/`
scaffold. Existing `CLAUDE.md` is backed up as `CLAUDE.legacy.md`.

### C. Manual

```bash
git clone https://github.com/ilkerprdal/Claude-Software-Office.git
cd your-project
bash /path/to/Claude-Software-Office/install.sh        # Mac/Linux
.\path\to\Claude-Software-Office\install.ps1           # Windows
```

Or just copy `.claude/` and `CLAUDE.md` from the cloned repo into your project.

### After install

```bash
claude
/start         # or /takeover if you have prior AI context
```

Agents auto-detect your language (verified: English, Turkish).

---

## How It Works

Software Office is built on three systems:

### 1. Slash Commands (`/command`)

Each `.md` file in `.claude/commands/` is a slash command.
Type `/` in chat, autocomplete shows them.

Command file structure:

```markdown
---
description: "What this does and when it triggers"
allowed-tools: Read, Write, ...
---

[Instructions Claude follows when this command runs]
```

When you call a command, Claude reads the body as a task description
and follows the steps. Most commands start with "engage [agent]".

### 2. Agents (Subagents)

Each `.md` file in `.claude/agents/` is a specialized subagent.
Each knows its domain and its boundaries.

Agent file structure:

```markdown
---
name: agent-name
description: "When to use this agent"
tools: Read, Write, Edit, ...    # accessible tools
model: opus / sonnet              # model assignment
---

[Agent's system prompt — responsibilities, rules, boundaries]
```

When a command says "engage agent-name", Claude loads that agent's
system prompt and works from its perspective. The agent stays in its
sandbox — e.g. `backend-developer` doesn't touch UI files.

### 3. CLAUDE.md and Configuration

`CLAUDE.md` (in project root) **auto-loads every session**:

- Tech stack
- Folder layout
- Collaboration protocol
- Coding standards (loaded via `@` references)
- Project memory (loaded via `@.claude/memory/*.md`)

So Claude enters every session knowing how this project works.

`.claude/settings.json` controls permissions: which commands auto-allow,
which are forbidden (`rm -rf` blocked, `.env` reads blocked).

---

## The Team

```
Directors (Opus)
├── tech-director         → architecture, tech selection, technical conflicts
└── product-manager       → scope, priority, product decisions

Leads (Sonnet, security-reviewer Opus)
├── engineering-lead      → code structure, API, code review
├── qa-lead               → test strategy, quality gate
├── design-lead           → UX, screen design, user flow
├── business-analyst      → requirements, existing system analysis, process
├── scrum-master          → sprint, standup, retro, backlog management
└── security-reviewer     → STRIDE threat model, OWASP audit, compliance

Specialists (Sonnet)
├── backend-developer     → APIs, services, DB, business logic
├── frontend-developer    → UI components, screens
└── devops                → CI/CD, deployment, environments
```

### How the Hierarchy Works

- **Vertical delegation**: Director → Lead → Specialist. Directors don't
  delegate directly to specialists (they go through leads).
- **Horizontal consultation**: Same-tier agents consult but don't decide.
  Backend ↔ Frontend talk about API contract, but architectural decisions
  go through engineering-lead.
- **Conflicts**: Design conflicts → product-manager.
  Technical conflicts → tech-director.

---

## Slash Commands

| Command | What It Does | Agent |
|---------|--------------|-------|
| **Onboarding** | | |
| `/takeover` | Import existing project context (context.md, .cursorrules, etc.) | — |
| `/start` | Smart: stage + tech stack detection, route | — |
| `/help` | Context-aware suggestion + full command list | — |
| **Design** | | |
| `/idea` | Turn idea into concept doc | product-manager |
| `/analyze` | Requirements / existing system analysis | business-analyst |
| `/architecture` | Technical architecture + ADRs | tech-director |
| **Sprint (Agile)** | | |
| `/create-stories` | Break work into stories | product-manager |
| `/backlog` | Backlog refinement | scrum-master |
| `/sprint-plan` | Sprint planning (capacity + selection) | scrum-master |
| `/standup` | Daily status + blockers | scrum-master |
| `/retro` | Sprint retrospective | scrum-master |
| **Development** | | |
| `/develop-story` | Implement a story end-to-end (full sprint context) | backend/frontend |
| `/feature` | Mid-tier: story + AC + implementation, no sprint ceremonies (50–500 LOC) | engineering-lead → specialist |
| `/quick-fix` | Lightweight fix path, no story (< 50 LOC) | backend/frontend/devops |
| `/code-review` | Code quality / architecture / test review | engineering-lead |
| **QA & Security** | | |
| `/qa-plan` | Test plan for sprint or feature | qa-lead |
| `/bug-report` | Structured bug report | qa-lead |
| `/bug-fix` | QA→Dev→QA bug fix loop | bug owner |
| `/security-review` | STRIDE + OWASP Top-10 audit | security-reviewer |
| **Decision / Knowledge** | | |
| `/consult` | Multi-agent parallel consultation (party mode) | (panel) |
| `/memory` | Manage project learnings | — |
| `/release-check` | Pre-release go/no-go checklist | tech-director |

---

## A Typical Workflow

Building a TODO app:

### 1. Concept (`/idea`)
- product-manager: "What problem? Who uses it?"
- You answer, it generates options, you pick
- Output: `docs/product/concept.md`

### 2. Requirements (`/analyze`)
- business-analyst: stakeholder questions, FR/NFR/constraints list
- If existing system: modules, dependencies, impact zones
- Output: `docs/analysis/requirements.md`

### 3. Architecture (`/architecture`)
- tech-director: "Web or mobile? Backend? DB?"
- 2-3 options per section + pros/cons
- Output: `docs/architecture/architecture.md` + `docs/adr/0001-*.md`

### 4. Stories (`/create-stories`)
- product-manager generates story list from architecture
- Output: `production/stories/001-user-login.md`,
  `002-todo-list.md`, `003-todo-add.md`...

### 5. Sprint Plan (`/sprint-plan`)
- scrum-master: capacity + story selection from backlog
- Output: `production/sprints/S01-2026-04-26.md`

### 6. Develop (`/develop-story 001`)
- engineering-lead reads story, routes to right specialist
- backend-developer (e.g.) proposes file list, gets approval
- Code + unit test together
- Test runs, acceptance criteria checked off

### 7. Code Review (`/code-review`)
- engineering-lead checks quality, architecture fit, tests
- Markdown report: APPROVED / REVISION / MAJOR REVISION

### 8. QA (`/qa-plan` + `/bug-report` + `/bug-fix`)
- qa-lead generates test plan
- If bug: structured `/bug-report`, then `/bug-fix` closes the loop

### 9. Standup, Retro, Memory
- `/standup` daily, `/retro` at sprint end
- Lessons go into `.claude/memory/`

### 10. Release (`/release-check`)
- tech-director: code, test, deployment, doc checklist
- Blocking items must pass — otherwise no GO

---

## Folder Layout

```
your-project/
├── CLAUDE.md                       # Auto-loaded each session
├── .claude/
│   ├── settings.json               # Permissions (allow/deny)
│   ├── agents/                     # 11 agent definitions
│   ├── commands/                   # 22 slash commands
│   ├── memory/                     # Accumulated learnings
│   └── docs/                       # Collaboration, coordination, standards
├── src/                            # Source code
├── tests/                          # Tests
├── docs/
│   ├── product/                    # Concept, vision (product-manager)
│   ├── analysis/                   # Requirements, existing system (business-analyst)
│   ├── architecture/               # Architecture (tech-director)
│   ├── adr/                        # Architecture Decision Records
│   └── ux/                         # Screen specs (design-lead)
└── production/
    ├── backlog.md                  # Ordered story list
    ├── stories/                    # Story files
    ├── sprints/                    # Sprint plans (SXX-yyyy-mm-dd.md)
    ├── retros/                     # Retrospectives
    ├── qa/
    │   ├── bugs/                   # Bug reports
    │   └── plan-*.md               # Test plans
    ├── standup-log.md              # Daily status
    └── session-state/
        └── active.md               # Session context
```

---

## Collaboration Protocol

**The user drives. Agents don't go autonomous.**

Each task: **Question → Options → Decision → Draft → Approval**

1. **Question**: agent asks what it doesn't know
2. **Options**: 2-4 alternatives with pros/cons
3. **Decision**: you pick
4. **Draft**: preview of what will be written
5. **Approval**: "May I write this to [path]?" — explicit

Agents stay within their domain. When unsure, they escalate
(specialist → lead → director).

Detail: [.claude/docs/collaboration.md](.claude/docs/collaboration.md)

---

## Language Support

Honest framing: this project **leverages Claude's existing multilingual
ability** rather than shipping localized templates. There are no per-language
story/sprint/retro shells (yet — see roadmap).

What it actually does:
- Each agent has a one-paragraph **Language Protocol** that says "detect the
  user's language and respond in it" — making the behavior explicit and
  consistent across the team.
- Tech terms (API, REST, ADR, Docker) stay in English.
- Code stays in English (industry convention).
- Comments, docs, chat output follow the user's language.

**Verified locally**: English, Turkish.
**Designed for**: any language Claude itself supports — Spanish, German,
French, Japanese, Arabic, Mandarin, etc. — but unverified by us. If you've
used it in another language, share a screenshot in
[Discussions](https://github.com/ilkerprdal/Claude-Software-Office/discussions).

**On the roadmap (not yet shipped)**: localized story/sprint/retro template
files (`templates/<lang>/`) so non-English users get native-language
scaffolding instead of English-only blanks.

---

## Customization

This is a **template**, not a locked framework.

- **Add/remove agent**: `.md` file in `.claude/agents/`
- **Add/remove command**: `.md` file in `.claude/commands/`
- **Change agent behavior**: edit the system prompt in its `.md`
- **Tighten/relax rules**: `.claude/docs/coding-standards.md`
- **Permissions**: `.claude/settings.json`

After adding a file, restart your Claude session (so new files load).

---

## FAQ

**Q: Does this work with Cursor / Copilot / Windsurf?**
A: The framework is built for **Claude Code** (`@anthropic-ai/claude-code`).
Other AI tools may pick up `CLAUDE.md` partially, but agent delegation, slash
commands, and `Task` calls are Claude Code features. If you're migrating from
Cursor / Copilot / Windsurf, `/takeover` imports their context files into our
memory layer.

**Q: Do I have to use all 22 commands?**
A: No. Even with zero commands, ~60% of the value applies passively:
agents auto-trigger on natural questions ("review this code", "fix the bug"),
`CLAUDE.md` enforces the collaboration protocol, memory persists across
sessions. Commands add explicit workflow discipline (sprint, retro, etc.).

**Q: What if my change is too small for a sprint?**
A: Three tiers, pick by size:
- **< 50 LOC, no design impact** → `/quick-fix` (no story, just fix + test)
- **50–500 LOC, single feature** → `/feature` (story + AC, no sprint ceremony)
- **> 500 LOC, multi-story** → `/sprint-plan` + `/develop-story` (full loop)

**Q: My language isn't English. Will it still work?**
A: Yes. Each agent has a Language Protocol — it detects your language and
responds in it. Code stays English (industry convention), but docs, comments,
and chat all follow your language. Tested with English and Turkish.

**Q: Can I add my own agents or commands?**
A: Yes. Drop new `.md` files in `.claude/agents/` or `.claude/commands/`.
Restart your Claude session to load them. See
[CONTRIBUTING.md](CONTRIBUTING.md) for the format.

**Q: Will it conflict with my company's existing process?**
A: Likely yes for 20+ person orgs with established Jira/ADRs/retros — see
"Who Is This For" above. For solo / small teams, this is the process; it
doesn't fight an existing one.

**Q: Does it call out to external services?**
A: No. Everything is local files + your existing Claude Code session.
No telemetry, no analytics. The only network calls are git operations
you control.

**Q: How do I update to a newer version?**
A: Re-run the installer (`curl|bash` or `irm|iex`). Your `CLAUDE.md` is
backed up as `CLAUDE.legacy.md`; `.gitignore` is merged. Custom files in
`.claude/agents/` you added stay; standard files get refreshed.

**Q: Can multiple developers share `.claude/memory/`?**
A: Yes — it's just markdown files. Treat them like any other project doc:
commit, review, merge in PRs. Conflicts are markdown line conflicts.

---

## Troubleshooting

### "Unknown command: /start"

You typed it before installing, or in a different folder than where you ran
the installer. Check that `.claude/commands/start.md` exists in the project
root, then restart Claude Code.

### "Agent responds in the wrong language"

The Language Protocol detects from recent messages. Send 1-2 messages in your
language, the agent will switch. If it doesn't, check that the
`### Language Protocol` section exists in the agent's `.md` file.

### "Permission denied" on Linux/Mac when running install.sh

```bash
chmod +x install.sh
bash install.sh
```

Or run directly via `bash install.sh` without making it executable.

### "Execution policy" error on Windows

If `install.ps1` refuses to run:
```powershell
powershell -ExecutionPolicy Bypass -File install.ps1
```

This is fine — the installer doesn't change system state.

### "Existing CLAUDE.md was overwritten"

Check for `CLAUDE.legacy.md` in your project root — that's your previous
version, automatically backed up. Re-merge what you need into `CLAUDE.md`.

### "No agent triggers when I describe my work"

Agent auto-triggering depends on Claude Code version. On older versions,
agents only run when explicitly invoked via `Task` or slash command.
Update Claude Code: `npm update -g @anthropic-ai/claude-code` (npm) or
re-run the platform installer.

### "Pre-commit hook says frontmatter invalid"

Run the validator:
```bash
python scripts/validate.py
```

It tells you which file and what's missing. Common fixes: missing
`description:` field, wrong `model` value (must be opus/sonnet/haiku/inherit).

### Something else?

Open an issue with the [Bug report template](https://github.com/ilkerprdal/Claude-Software-Office/issues/new?template=bug_report.yml).

---

## License

MIT
