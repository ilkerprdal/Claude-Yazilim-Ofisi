# Changelog

All notable changes to this project follow [Keep a Changelog](https://keepachangelog.com/en/1.1.0/) and [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

## [Unreleased]

### Added

- **`/quick-fix` command** — scale-adaptive lightweight fix path. Skips
  story / sprint / ceremonies for changes <50 LOC, single-purpose, no
  architectural impact. Refuses to be the security-fix path
  (delegates to `security-reviewer`).
- **FAQ + Troubleshooting** sections in README covering common questions
  (other AI tools, language detection, install errors, validator usage).
- **CONTRIBUTING.md** — agent / command authoring format, validation,
  commit conventions, code-of-conduct expectations.
- **Issue templates** (`.github/ISSUE_TEMPLATE/`):
  - `bug_report.yml`
  - `feature_request.yml`
  - `agent_proposal.yml`
- **PR template** (`.github/PULL_REQUEST_TEMPLATE.md`).
- GitHub Discussions linked from issue config (questions go there, not issues).

### Changed

- Total commands: 20 → 21 (added `/quick-fix`).

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
- **Single-file Windows installer** (`software-office-install.bat`) with
  embedded payload — no external dependencies.
- **Bash installer** (`software-office-install.sh`) for Linux and macOS.
- **PowerShell installer** (`software-office-install.ps1`) for Windows.
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
- **`examples/todo-cli/`** — a complete worked example.
- Frontmatter linter script (`scripts/validate.py`).

### Changed

- Project rebranded from `Claude-Yazilim-Ofisi` to `Claude-Software-Office`
  with English as the primary language.

### Documentation

- README with installation, workflow, command table, anti-personas.
- `SECURITY.md`, `CHANGELOG.md`.
- `.claude/docs/`: collaboration, coordination, coding standards.

[Unreleased]: https://github.com/ilkerprdal/Claude-Software-Office/compare/v0.1.0...HEAD
[0.1.0]: https://github.com/ilkerprdal/Claude-Software-Office/releases/tag/v0.1.0
