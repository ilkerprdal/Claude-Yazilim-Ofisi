# Changelog

All notable changes to this project follow [Keep a Changelog](https://keepachangelog.com/en/1.1.0/) and [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

## [Unreleased] — v0.2.0 lean flow restructure (BREAKING)

The framework was 13 agents and 24 commands modeling full Scrum (sprints,
retros, standups, story points). For solo / small teams that was overhead,
not value. v0.2 collapses it into a tight linear flow.

### BREAKING

- **The Scrum process is gone.** No more sprint planning, retrospectives,
  standups, or backlog refinement. Stories no longer have story points.
  If you used those features, this is a hard break — pin to v0.1.1 or
  use a heavier framework (e.g. BMAD-METHOD).
- **Agents removed (11):** `business-analyst`, `product-manager`,
  `scrum-master`, `design-lead`, `design-reviewer`, `technical-writer`,
  `frontend-developer`, `backend-developer`, `engineering-lead`,
  `tech-director`, `qa-lead`. Their core scope merged into the new agents below.
- **Commands removed (15):** `/idea`, `/analyze`, `/architecture`,
  `/create-stories`, `/backlog`, `/sprint-plan`, `/standup`, `/retro`,
  `/develop-story`, `/code-review`, `/api-design`, `/qa-plan`,
  `/bug-report`, `/design-review`, `/consult`. The flow no longer needs them.
- **Folder structure changed:** `production/sprints/`, `production/retros/`,
  `production/standup-log.md`, `docs/product/`, `docs/analysis/`,
  `docs/ux/` are no longer used by the default flow. Existing projects on
  v0.1.x keep their files; v0.2 just doesn't write to those paths.

### Added

- **`researcher` agent** — first in the flow. Investigates the topic
  (codebase grep, library docs, prior incidents) and returns evidence
  with file/line pointers. Does NOT recommend an approach. The qa step
  turns evidence into a plan.
- **`/research` command** — standalone investigation. Drives the
  `researcher` agent without kicking off the build flow. Use it to
  scope a problem (where does X live? does library Y support Z?) before
  deciding whether it deserves a `/feature`, `/quick-fix`, or nothing.
  Returns evidence + open questions; the next step is the user's call.
- **`qa` agent** (replaces `qa-lead` + `business-analyst`) — two modes:
  - Mode A (analysis): hypothesis + AC + test plan + risk flags
  - Mode B (validation): walks each AC against evidence after the developer ships
- **`tech-lead` agent** (replaces `engineering-lead`) — splits qa's spec
  into independent, named-files, AC-mapped tasks (parallelizable where
  possible), then reviews developer output against quality bars.
- **`developer` agent** (replaces `backend-developer` + `frontend-developer`)
  — implements end-to-end. One agent, full stack within the task.
  Stack-detected per project. Multiple instances run in parallel for
  parallelizable tasks.
- **`cto` agent** (replaces `tech-director` + `product-manager`) — top-tier,
  on-call. Stack pick, architectural change, breaking API, scope conflict,
  release sign-off. NOT in the default flow.
- **On-call scope** explicitly added to `security-reviewer` and `devops` —
  they're invoked only when their trigger fires (qa risk flag, infra task,
  release audit). Routine work routed to either is returned to the flow.

### Changed

- **The default flow is now linear:**
  ```
  researcher → qa → tech-lead → developer(s) → tech-lead → qa → done
  ```
- **`/feature` rewritten** — drives the linear flow above. No longer a
  "mid-tier" between quick-fix and sprint; it's the default for any change.
- **`/quick-fix` rewritten** — short-circuits to developer + tech-lead glance.
  Skips researcher, qa-analysis, task breakdown.
- **`/bug-fix` rewritten** — researcher → developer → qa loop. Regression
  test still required.
- **`/release-check` rewritten** — drives `cto` for the GO/NO-GO call.
- **`/security-review` rewritten** — explicitly on-demand; the default
  flow only invokes it when qa flags risk.
- **`/start` and `/help` rewritten** — reflect the smaller surface (no
  stage-detection routing through `/idea` → `/analyze` → `/architecture`).
- **`CLAUDE.md` rewritten** — describes the lean flow, the 7 agents, the
  9 commands, hard gates.
- **`.claude/docs/coordination.md` rewritten** — linear flow + on-call
  triggers + conflict resolution. Replaces the old vertical/horizontal
  delegation rules.
- **`.claude/docs/collaboration.md` updated** — speed mode + hard gates
  remain; "Inter-Agent" section trimmed to the linear flow.
- **`README.md` and `README.tr.md` rewritten** — new badges (7 / 9), new
  team section, new workflow walk-through (researcher → qa → tech-lead →
  developer with the password-reset example).
- **`plugin.json`** — version 0.1.1 → 0.2.0; description and keywords
  updated; dropped `agile` / `scrum` / `scale-adaptive`; added `lean-flow`.
- **`demo/social-preview.svg`** — counts and workflow updated.

### Notes

- `demo/workflow.cast` still references the old `/idea` → `/architecture`
  → `/develop-story` → `/code-review` flow. The recording will be redone
  with the new flow before v0.2.0 is tagged.
- `examples/todo-cli/` artifacts (sprints, retros, code-review reports)
  are historical snapshots from v0.1.x. They're left as-is — useful as a
  before/after reference, not as a template for v0.2 work.

## [0.1.1] — 2026-04-27

### Added

- **Plugin format** — Software Office is now installable as a Claude Code
  plugin:
  - `.claude-plugin/plugin.json` manifest with custom paths pointing into
    `.claude/agents/` and `.claude/commands/` (existing structure preserved).
  - `.claude-plugin/marketplace.json` so users can subscribe via
    `/plugin marketplace add ilkerprdal/Claude-Software-Office`.
- **Safe hooks** under `hooks/`:
  - `post-edit-validate.sh` — runs the frontmatter validator after
    Write/Edit/MultiEdit. Warns to stderr; never blocks.
  - `pre-bash-hint.sh` — reminds to run tests before `git push` if a test
    framework is detected. Hint only; never blocks.
  - All hooks fail-open: missing Python, missing git, missing test manifest,
    or missing validator → silent no-op.
  - Windows-Store-stub Python detection (the stub passes `command -v` but
    errors on actual run; we now verify with `--version`).
- **LICENSE file** — MIT, matching what README claimed. Was missing in
  v0.1.0; the repo's `license` field on GitHub returned `null`.
- **GitHub Actions CI** (`.github/workflows/ci.yml`):
  - frontmatter validator (`scripts/validate.py --strict`)
  - example tests (`pytest` in `examples/todo-cli/`, 13 tests)
  - installer syntax check (`bash -n install.sh`, PowerShell parser)
- **README badges** — CI status, license, release, tests passing,
  agent/command counts, multilingual.
- **`/quick-fix` command** — scale-adaptive lightweight fix path. Skips
  story / sprint / ceremonies for changes <50 LOC, single-purpose, no
  architectural impact. Delegates security fixes to `security-reviewer`.
- **examples/todo-cli/production/qa/test-evidence-S01.md** — captured
  pytest output and acceptance-criteria → test mapping.
- **examples/todo-cli/production/qa/code-review-S01.md** — engineering-lead
  review report covering quality bars, OWASP, perf, observability.
- examples/todo-cli/README updated with explicit "13/13 passing" callout.
- **FAQ + Troubleshooting** sections in README.
- **CONTRIBUTING.md** — agent/command authoring format, validation,
  commit conventions, code-of-conduct expectations.
- **Issue templates** (`.github/ISSUE_TEMPLATE/bug_report.yml`,
  `feature_request.yml`, `agent_proposal.yml`, `config.yml`).
- **PR template** (`.github/PULL_REQUEST_TEMPLATE.md`).
- README "Installation" section now lists three install paths
  (plugin, one-liner, manual).

### Changed

- **Multilingual claim tightened in README**: "verified: EN + TR;
  designed for any language Claude supports". Asks the community for
  screenshots in other languages via Discussions.
- GitHub repo description: now reflects accurate counts (11 agents,
  21 commands).
- Total commands: 20 → 21 (added `/quick-fix`).

### Fixed

- `scripts/validate.py` now forces UTF-8 stdout/stderr and uses
  ASCII-only severity markers (`[ERROR]`, `[WARN]`), avoiding
  `UnicodeEncodeError` on Windows console encodings (cp1254 etc.).
- examples/todo-cli/README run instructions corrected (`pip install -e
  ".[dev]"`, `python -m src` instead of `python -m todo_cli`).
- License integrity — README declared MIT but no LICENSE file existed.

## [0.1.0] — 2026-04-27

The first tagged release. The project is functional and usable, but APIs
(agent names, command names, output formats) may still change before 1.0.

### Added

- **11 specialized agents** in `.claude/agents/`:
  Directors (tech-director, product-manager),
  Leads (engineering-lead, qa-lead, design-lead, business-analyst,
  scrum-master, security-reviewer),
  Specialists (backend-developer, frontend-developer, devops).
- **20 slash commands** in `.claude/commands/` covering onboarding,
  design, sprint cycle, development, QA, security, and release.
- **Bash installer** (`install.sh`) for macOS/Linux.
- **PowerShell installer** (`install.ps1`) for Windows.
- **`install.bat`** thin wrapper for double-click users.
- **Multilingual agents** — Language Protocol auto-detects user language
  and responds in it (tested EN + TR).
- **`/takeover` command** to import context from prior AI tools
  (Cursor, Copilot, Windsurf, Aider, Continue, generic context files).
- **Memory layer** at `.claude/memory/` for persistent project learnings,
  auto-loaded each session via `CLAUDE.md`.
- **Agile workflow**: `/sprint-plan`, `/standup`, `/retro`, `/backlog`.
- **Closed bug-fix loop**: `/bug-fix` enforces regression test + QA gate.
- **STRIDE threat modeling + OWASP Top-10 audit** via `/security-review`.
- **Cross-cutting concerns** baked into agent prompts: stack detection,
  performance targets, security checklist, resilience patterns,
  observability, Definition of Done.
- **30-second animated SVG demo** in README.
- **Quality bars** for code review (function/file/complexity limits).
- **Coverage targets**: 90% for critical paths, 70% standard.
- **`examples/todo-cli/`** — a complete worked example with passing tests.
- Frontmatter linter script (`scripts/validate.py`).

### Changed

- Project rebranded from `Claude-Yazilim-Ofisi` to `Claude-Software-Office`
  with English as the primary language.

### Documentation

- README with installation, workflow, command table, anti-personas.
- `SECURITY.md`.
- `.claude/docs/`: collaboration, coordination, coding standards.

[Unreleased]: https://github.com/ilkerprdal/Claude-Software-Office/compare/v0.1.1...HEAD
[0.1.1]: https://github.com/ilkerprdal/Claude-Software-Office/compare/v0.1.0...v0.1.1
[0.1.0]: https://github.com/ilkerprdal/Claude-Software-Office/releases/tag/v0.1.0
