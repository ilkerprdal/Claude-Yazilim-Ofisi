# Software Office

Turn your Claude Code session into a small, organized software office.
**11 agents. 21 slash commands. A simple Agile team. Multilingual.**

> Inspired by Claude Code Game Studios + BMAD-METHOD, targeted at general
> software development. Agents detect your language and respond in it.

## ▶ Demo

![Software Office workflow](demo/workflow.svg)

A 30-second walk-through: `/start` → `/idea` → `/architecture` →
`/develop-story` → `/code-review`. The team picks the right agent at each
step, applies quality bars (security/performance/tests), and lets you
approve every change.

---

## Table of Contents

1. [What It Does](#what-it-does)
2. [Installation](#installation)
3. [How It Works](#how-it-works)
4. [The Team](#the-team)
5. [Slash Commands](#slash-commands)
6. [A Typical Workflow](#a-typical-workflow)
7. [Folder Layout](#folder-layout)
8. [Collaboration Protocol](#collaboration-protocol)
9. [Multilingual](#multilingual)
10. [Customization](#customization)

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

## Why Use This (and Why Not)

### ✅ Use Software Office if you are...
- A **solo developer** wanting team-style discipline
- A **small team (2–5 people)** without a formal process yet
- Building an **MVP, prototype, or internal tool** that will live ≥ 2 months
- On **web / API / CLI / mobile** stacks (frontend + backend)
- Joining an **existing project** with prior AI context (Cursor, Copilot, etc.) — `/takeover` brings it forward
- Working in a **non-English** language and tired of English-only tools

### ❌ Skip Software Office if you are...
- Writing a **5-line script** — `claude` directly is faster
- In a **hackathon** — speed > discipline
- Part of a **20+ person company** with established Jira/ADRs/retros — it'll clash
- Doing **bleeding-edge AI/ML R&D** — agents' domain knowledge is general
- Working in **embedded / hardware / blockchain** — niche stacks aren't covered
- Just want to **chat about code** — overkill for Q&A

### How It Compares

| Need | Direct Claude | Software Office | Big Frameworks (BMAD, etc.) |
|------|---------------|-----------------|-----------------------------|
| Quick fix / 1-shot | ✅ Best | ❌ Overkill | ❌ Overkill |
| Long-running project | ❌ Loses context | ✅ Built for it | ✅ Built for it |
| Setup complexity | None | Single `.bat`/`.sh` | Node + npm + plugins |
| Number of agents | 1 (generic) | **11 (curated)** | 50+ (overwhelming) |
| Multilingual | Implicit | **Explicit Protocol** | Mostly English-only |
| Sprint / Agile loop | ❌ | ✅ | ✅ |
| Existing-project takeover | ❌ Manual | ✅ `/takeover` | Varies |
| Bus factor risk | N/A | High (solo maintainer) | Lower (community) |

If you need **maximum sophistication**, look at BMAD-METHOD.
If you need **maximum simplicity with structure**, this is for you.

---

## Installation

### One-liner (recommended)

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

### Manual

```bash
git clone https://github.com/ilkerprdal/Claude-Software-Office.git
cd your-project
bash /path/to/Claude-Software-Office/install.sh           # Mac/Linux
.\\path\\to\\Claude-Software-Office\\install.ps1           # Windows
```

Or just copy `.claude/`, `CLAUDE.md` from the cloned repo.

### After install

```bash
claude
/start         # or /takeover if you have prior AI context (context.md, .cursorrules, etc.)
```

Agents auto-detect your language (English, Turkish, more).

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
| `/develop-story` | Implement a story end-to-end | backend/frontend |
| `/quick-fix` | Lightweight fix path (no sprint ceremonies) | backend/frontend/devops |
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
│   ├── agents/                     # 10 agent definitions
│   ├── commands/                   # 19 slash commands
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

## Multilingual

Each agent has a **Language Protocol** in its system prompt:

> Detect the user's language from their messages and respond in the same language.
> Default: English. Tech terms (API, REST, ADR, Docker, etc.) stay in English.
> Files you write follow the user's language preference.

So whether you write in English, Turkish, German, or Japanese, agents
respond in your language. Code stays in English (industry convention).
Documentation files follow your language.

Tested with: English, Turkish.
Should work with: any language Claude supports.

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

**Q: Do I have to use all 20 commands?**
A: No. Even with zero commands, ~60% of the value applies passively:
agents auto-trigger on natural questions ("review this code", "fix the bug"),
`CLAUDE.md` enforces the collaboration protocol, memory persists across
sessions. Commands add explicit workflow discipline (sprint, retro, etc.).

**Q: What if I just want a quick fix, not a full sprint?**
A: Use `/quick-fix [description]` — it skips story creation, sprint planning,
and ceremonies. Goes straight to code + test.

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
"Why Not" above. For solo / small teams, this is the process; it doesn't
fight an existing one.

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
