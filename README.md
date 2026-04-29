# Software Office

[![CI](https://github.com/ilkerprdal/Claude-Software-Office/actions/workflows/ci.yml/badge.svg)](https://github.com/ilkerprdal/Claude-Software-Office/actions/workflows/ci.yml)
[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](LICENSE)
[![Release](https://img.shields.io/github/v/release/ilkerprdal/Claude-Software-Office)](https://github.com/ilkerprdal/Claude-Software-Office/releases)
[![Validator](https://img.shields.io/badge/frontmatter-validated-brightgreen)](scripts/validate.py)
![Agents](https://img.shields.io/badge/agents-7-blueviolet)
![Commands](https://img.shields.io/badge/commands-10-blue)

Turn your Claude Code session into a small, organized software office.
**7 agents. 10 slash commands. One linear flow. No sprint, no retro, no standup.**

🇹🇷 **Türkçe**: [README.tr.md](README.tr.md)

> **Status: early preview** (v0.2.x). Verified locally. APIs (agent names,
> command behavior, output formats) may still change before 1.0.
> Community feedback wanted.
>
> Inspired by Claude Code Game Studios and the broader Agile-agent ecosystem
> (BMAD-METHOD and others). Deliberately curated and smaller than those.

---

## Table of Contents

1. [What It Does](#what-it-does)
2. [The Flow](#the-flow)
3. [Who Is This For](#who-is-this-for)
4. [Installation](#installation)
5. [The Team](#the-team)
6. [Slash Commands](#slash-commands)
7. [A Typical Workflow](#a-typical-workflow)
8. [Folder Layout](#folder-layout)
9. [Language Support](#language-support)
10. [Customization](#customization)

---

## What It Does

A single Claude session is powerful but unstructured. Nobody asks "do we
really need this?", nobody enforces code review, nobody catches when you
skip tests.

**Software Office** gives Claude a tight, linear team:

- **researcher** investigates the topic and returns evidence
- **qa** turns that into a testable spec, then validates the result at the end
- **tech-lead** splits the spec into tasks and reviews the code
- **developer** implements the tasks (multiple in parallel for parallelizable work)
- **cto, security-reviewer, devops** sit on-call — never in the default flow,
  pulled in only when their trigger fires

You still make every decision — but inside a small team that asks the right
questions, knows its boundaries, and doesn't ceremonialize routine work.

---

## The Flow

```
researcher → qa (analysis) → tech-lead (tasks) → developer(s) → tech-lead (review) → qa (validation) → done
```

That's `/feature` — the default path for any non-trivial change.

| Path | When | Steps |
|---|---|---|
| `/feature` | Default. Any change that isn't a one-liner. | researcher → qa → tech-lead → developer → tech-lead → qa |
| `/quick-fix` | < 50 LOC, no architecture impact. | developer + tech-lead glance |
| `/bug-fix` | A reported bug. | researcher → developer → qa (regression test required) |

**On-call roles** are invoked by trigger only:

| Role | Trigger |
|---|---|
| **cto** | Stack pick, architectural change, breaking API, scope conflict, release sign-off |
| **security-reviewer** | qa flagged risk (auth / PII / payments / files / migration), pre-release audit |
| **devops** | CI / Docker / deployment / observability work in the task list |

If qa or tech-lead pulls one of these in for routine work, that role
returns it. The flow stays lean.

---

## Who Is This For

### Good fit
- A **solo developer** or **small team (2–5)** wanting a tight, opinionated flow
- Working on a **small-to-mid project** in a **mainstream stack** (web, REST/GraphQL API, CLI, library)
- Joining a **brownfield project** with prior AI assistant context (Cursor, Copilot, Aider) — `/takeover` brings it forward
- Building **end-to-end with a single AI session** as your team

### Wrong tool
- **One-shot scripts** (< 100 LOC) — direct Claude Code is faster
- **Hackathons / time-boxed sprints** — flow overhead doesn't pay off
- **20+ person orgs** with established Jira / sprint / retro process — this is too small to plug into yours
- **Bleeding-edge AI/ML research, embedded firmware, hardware drivers, blockchain protocol design** — agent domain knowledge is general-purpose
- **Pair-programming chat** for a quick question — slash-command overhead is overkill
- **Enterprise multi-team coordination** with 50+ specialized agents → look at [BMAD-METHOD](https://github.com/bmad-code-org/BMAD-METHOD)

If you wanted scrum, sprints, retros, standups — those are gone. This is
deliberately a flow framework, not an Agile framework.

---

## Installation

Three install paths.

### A. Plugin install (Claude Code 2.x)

In a Claude Code session:

```
/plugin marketplace add ilkerprdal/Claude-Software-Office
/plugin install claude-software-office@claude-software-office-marketplace
```

Auto-updates via `/plugin update`, scoped to user or project.

### B. One-liner

**macOS / Linux / Git Bash on Windows:**
```bash
curl -fsSL https://raw.githubusercontent.com/ilkerprdal/Claude-Software-Office/main/install.sh | bash
```

**Windows PowerShell:**
```powershell
irm https://raw.githubusercontent.com/ilkerprdal/Claude-Software-Office/main/install.ps1 | iex
```

Run from your project root. Installs `.claude/`, `CLAUDE.md`, `.gitignore`,
and a `production/` scaffold. Existing `CLAUDE.md` is backed up as
`CLAUDE.legacy.md`.

### C. Manual

```bash
git clone https://github.com/ilkerprdal/Claude-Software-Office.git
cd your-project
bash /path/to/Claude-Software-Office/install.sh        # Mac/Linux
.\path\to\Claude-Software-Office\install.ps1           # Windows
```

Or copy `.claude/` and `CLAUDE.md` from the cloned repo into your project.

### After install

```bash
claude
/start         # or /takeover if you have prior AI context
```

Agents auto-detect your language (verified: English, Turkish).

---

## The Team

```
On-call (Opus)
└── cto                 → stack, architecture, breaking change, release sign-off

The flow (Sonnet)
├── researcher          → investigates topic, returns evidence (no opinion)
├── qa                  → spec + AC + test plan, then validates result
├── tech-lead           → splits into tasks, reviews code
└── developer           → implements end-to-end (backend, frontend, tests)

On-call (Sonnet, security-reviewer Opus)
├── security-reviewer   → STRIDE / OWASP audit when qa flags risk
└── devops              → CI/CD, deployment, observability when needed
```

### How it works

- **Linear delegation**: each step in the flow consumes the previous step's output. No "ask anyone anytime" branching.
- **Parallel developers**: tech-lead marks tasks parallelizable; multiple developer instances run simultaneously when tasks don't share files.
- **Conflicts** route up: code structure → tech-lead, test sufficiency → qa, anything bigger → cto.
- **On-call roles return work** if pulled in for routine tasks that don't need them. They're guardrails, not bottlenecks.

---

## Slash Commands

| Command | Purpose | Drives |
|---|---|---|
| **Onboarding** | | |
| `/start` | Detect stack + state, suggest next | — |
| `/takeover` | Import prior AI context (Cursor / Copilot / Windsurf / Aider) | — |
| `/help` | Smart suggestion + command list | — |
| **Build** | | |
| `/research` | Standalone investigation — facts only, no build | researcher |
| `/feature` | Default flow for any change | researcher → qa → tech-lead → developer |
| `/quick-fix` | Tiny change, skip the flow | developer + tech-lead |
| `/bug-fix` | Locate, fix, regression-test | researcher → developer → qa |
| **Gates** | | |
| `/security-review` | On-demand security audit (STRIDE + OWASP) | security-reviewer |
| `/release-check` | Pre-release GO / NO-GO | cto |
| **Knowledge** | | |
| `/memory` | View / add project learnings | — |

`/research` is the only command that drives the researcher *without* kicking
off the build flow. Use it when you want to scope a problem before deciding
whether it deserves a `/feature`, `/quick-fix`, or nothing at all.

---

## A Typical Workflow

Building a TODO app's password reset:

### 1. Start (`/feature add password reset`)

The flow kicks off. Five steps:

### 2. researcher
- Greps the codebase: where is auth, where are emails sent, what email lib is wired up?
- Notes prior incidents on the auth area
- Returns: file pointers + open questions. No opinion on the approach.

### 3. qa (analysis)
- Reads researcher's brief + your ask
- Writes hypothesis + 5 AC (request token, expiry window, single-use, error messages don't enumerate accounts, token-in-URL secure)
- Test plan: 3 unit + 2 integration. Risk flag fires (touches auth) → security-reviewer is queued.
- Output: `production/qa/spec-password-reset.md`

### 4. security-reviewer (triggered by risk flag)
- STRIDE on the flow, OWASP A01/A04/A07 spot-check
- Findings (token entropy, account enumeration, log content) added to the spec

### 5. tech-lead (tasks)
- Splits the spec into 4 tasks, two parallelizable
- Output: `production/stories/password-reset.md` with named files per task

### 6. developer (implements)
- Each task: code + test together; runs tests; reports
- Stays in the named files; surfaces if scope leaks

### 7. tech-lead (review)
- Quality bars, AC coverage, security smoke
- Verdict: `APPROVE_WITH_NITS` (one nit: log message wording)
- Developer fixes the nit

### 8. qa (validation)
- Walks each AC against evidence; tests pass
- GATE: PASS
- Output: `production/qa/validation-password-reset.md`

### 9. Done

No standup. No retro. No sprint roll-over. The feature is done when qa
GATE = PASS.

For releases: `/release-check` — cto walks the gate and signs GO/NO-GO.

---

## Folder Layout

```
your-project/
├── CLAUDE.md                       # Auto-loaded each session
├── .claude/
│   ├── settings.json               # Permissions (allow/deny)
│   ├── agents/                     # 7 agent definitions
│   ├── commands/                   # 9 slash commands
│   ├── memory/                     # Accumulated learnings
│   └── docs/                       # Coordination, collaboration, standards
├── src/                            # Source code
├── tests/                          # Tests
├── docs/
│   ├── architecture/               # cto's architecture docs
│   ├── adr/                        # Architecture Decision Records
│   ├── api/                        # OpenAPI / GraphQL SDL / .proto
│   └── security/                   # security-reviewer threat models
└── production/
    ├── qa/
    │   ├── spec-*.md               # qa Mode A specs
    │   ├── validation-*.md         # qa Mode B validations
    │   ├── bugs/                   # bug reports
    │   └── security-review-*.md
    ├── stories/                    # tech-lead task breakdowns
    ├── releases/                   # cto GO/NO-GO decisions
    └── session-state/
        └── active.md               # session context
```

No `sprints/`, no `retros/`, no `standup-log.md` — those are gone.

---

## Language Support

This project **leverages Claude's existing multilingual ability** rather
than shipping localized templates.

What it actually does:
- Each agent has a **Language Protocol** that says "detect the user's language and respond in it" — making the behavior explicit and consistent.
- Tech terms (API, REST, ADR, Docker) stay in English.
- Code stays in English (industry convention).
- Comments, docs, chat output follow your language.

**Verified locally**: English, Turkish.
**Designed for**: any language Claude itself supports — but unverified by us.
If you've used it in another language, share a screenshot in
[Discussions](https://github.com/ilkerprdal/Claude-Software-Office/discussions).

---

## Customization

This is a **template**, not a locked framework.

- **Add/remove agent**: `.md` file in `.claude/agents/`
- **Add/remove command**: `.md` file in `.claude/commands/`
- **Change agent behavior**: edit the system prompt in its `.md`
- **Tighten/relax rules**: `.claude/docs/coding-standards.md`
- **Permissions**: `.claude/settings.json`

After adding a file, restart your Claude session.

---

## FAQ

**Q: What happened to sprints, retros, standups, story points?**
A: Gone in v0.2. The previous setup had 13 agents and 24 commands modeling a
full Scrum process. For solo / small teams that was overhead, not value.
This version is a flow framework, not an Agile framework. If you need sprint
ceremonies, use a heavier tool — see "Wrong tool" above.

**Q: Does this work with Cursor / Copilot / Windsurf?**
A: The framework is built for **Claude Code** (`@anthropic-ai/claude-code`).
Other AI tools may pick up `CLAUDE.md` partially, but agent delegation, slash
commands, and `Task` calls are Claude Code features. `/takeover` imports
their context files into our memory layer.

**Q: My change is too small for `/feature`.**
A: Use `/quick-fix` (< 50 LOC, no architecture impact). It skips researcher
and qa-analysis — goes straight to developer with a tech-lead glance.

**Q: My language isn't English. Will it still work?**
A: Yes. Each agent has a Language Protocol — it detects your language and
responds in it. Code stays English (industry convention), but docs, comments,
and chat all follow your language. Tested with English and Turkish.

**Q: Can I add my own agents or commands?**
A: Yes. Drop new `.md` files in `.claude/agents/` or `.claude/commands/`.
Restart your Claude session to load them. See
[CONTRIBUTING.md](CONTRIBUTING.md) for the format.

**Q: Will it conflict with my company's existing process?**
A: Likely yes for any org with established Jira / sprint / retro process —
this doesn't try to model those. For solo / small teams, this *is* the
process.

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

The Language Protocol detects from recent messages. Send 1–2 messages in your
language, the agent will switch. If it doesn't, check that the
`### Language Protocol` section exists in the agent's `.md` file.

### "Permission denied" on Linux/Mac when running install.sh

```bash
chmod +x install.sh
bash install.sh
```

Or run directly via `bash install.sh` without making it executable.

### "Execution policy" error on Windows

```powershell
powershell -ExecutionPolicy Bypass -File install.ps1
```

The installer doesn't change system state.

### "Existing CLAUDE.md was overwritten"

Check for `CLAUDE.legacy.md` in your project root — that's your previous
version, automatically backed up. Re-merge what you need into `CLAUDE.md`.

### "Pre-commit hook says frontmatter invalid"

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
