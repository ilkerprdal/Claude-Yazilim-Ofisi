# Changelog

All notable changes to this project follow [Keep a Changelog](https://keepachangelog.com/en/1.1.0/) and [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

## [Unreleased]

### Added

- **`technical-writer` agent** (Lead-tier, sonnet) — owns README freshness,
  CHANGELOG discipline, ADR hygiene, API docs (rendered from schema), user
  help, drift detection. Closes the long-standing gap where project
  documentation had no explicit owner. README freshness audit (counts,
  badges, links, install instructions) is now a release-gate checklist.
- **`/api-design` command** — schema-first API design path. Produces
  OpenAPI / GraphQL SDL / `.proto` schemas before any implementation.
  Engineering-lead drives, backend-developer reviews feasibility, qa-lead
  reviews testability (contract tests), security-reviewer engaged for
  auth/PII/payments/files. Includes mandatory OWASP API Security Top 10
  pass at schema time. Closes the "API contract sahipsiz" gap raised in
  reviewer feedback.
- **`/feature` command** — mid-tier scale-adaptive path between `/quick-fix`
  and full sprint cycle. Story + AC + implementation + code review, but no
  sprint planning or retro. Designed for 50–500 LOC self-contained features
  (~1–3 days of work). Mandatory `security-reviewer` pass when feature
  touches auth/PII/payments/files.
- **README "Differentiators" section** — explicitly calls out what this
  project does differently from larger Agile-agent frameworks: brownfield-first
  (`/takeover`), scale-adaptive workflow (three explicit tiers),
  defensive infrastructure (fail-open hooks, three install paths),
  explicit boundaries (anti-personas, vertical delegation, memory layer),
  honest scope (single-maintainer, early-preview status).
- **Total agents: 11 → 12** (added `technical-writer`).
- **Total commands: 21 → 23** (added `/feature`, `/api-design`).

### Changed

- **`business-analyst` agent deepened** (2.5 KB → ~10 KB) with concrete
  elicitation methodology: 5 Whys / Jobs-to-be-Done / Event Storming /
  User Story Mapping / Stakeholder Interview / Document Mining / System
  Walkthrough — with "when to use which" guidance. Added ambiguity
  reduction protocol (Subject/Action/Object/Quantifier/Conditions/Negation),
  requirement categorization with mandatory source attribution, BPMN
  notation guidance, compliance discovery checklist (KVKK/GDPR/HIPAA/PCI/
  COPPA), stakeholder conflict resolution framing, brownfield existing-system
  analysis protocol, and a Definition of Done.
- **`scrum-master` agent deepened** (2.5 KB → ~10 KB) with operational
  rigor: velocity calculation (median over 3-5 sprints, not single
  number), capacity formula with focus-factor (typical 0.6-0.7 for
  solo / small team), sprint-goal one-sentence discipline, planning poker
  process, blocker escalation SLA (24h owner / 24-48h Lead / 48-72h
  Director / 72h+ User), burn-down / burn-up tracking, structured retro
  template with mandatory experiments-with-owner-and-checkpoint, backlog
  refinement rules (90-day stale, 13+ point split, vague-AC bounce-back),
  cross-team coordination guidance, and per-ceremony Definitions of Done.
- **`tech-director` cross-cutting concerns extended** with two new axes:
  - **Cost / FinOps**: cloud spend at MVP scale, cost drivers, egress,
    third-party API quotas (LLM tokens, payments, SMS), auto-scaling caps,
    storage tiering, build-vs-buy, vendor lock-in, reserved/savings plans,
    unit economics check.
  - **Data Architecture**: schema evolution / migration strategy,
    backward-compatibility windows, partitioning / sharding,
    read/write split + replication lag, backup RTO/RPO targets.
  Output format updated to surface all 7 cross-cutting axes (was 4).
- **`qa-lead` agent deepened** with full test discipline:
  - **Test pyramid** (70/20/10 unit/integration/E2E) with anti-pattern
    callouts (ice cream cone, hourglass, single-tier).
  - **Contract testing** guidance per stack (Pact, OpenAPI+Schemathesis,
    GraphQL schema diffing, gRPC `buf breaking`, in-repo contract suite).
  - **Performance testing** taxonomy (smoke / load / stress / soak / spike)
    with tool hints (k6, Locust, JMeter, Vegeta, wrk, Lighthouse CI).
  - **Flaky test management**: detection (3-5 reruns), tracking by
    failure rate, **48-hour fix-or-delete rule**, common causes ordered
    by frequency.
  - **Mutation testing** guidance (Stryker / mutmut / cosmic-ray / PIT)
    for critical-path modules, > 70% mutation score target.
  - **Test data management** rules (no real PII, transaction-rolled-back
    integration tests, builder/factory patterns).
  - **Accessibility test automation** (axe-core, pa11y, lighthouse-ci)
    paired with design-lead's WCAG checklist.
  - Output format updated to surface pyramid distribution, contract
    tests, perf detail, a11y, flaky queue.
- **`engineering-lead` agent deepened**:
  - **Review verdict granularity**: APPROVE / APPROVE_WITH_NITS /
    REQUEST_CHANGES / BLOCK (was binary). Findings tagged
    `nit` / `suggestion` / `concern` / `blocker`.
  - **API design discipline**: schema-first preferred (OpenAPI / GraphQL
    SDL / `.proto` / AsyncAPI), naming + envelope + pagination + versioning
    conventions.
  - **Breaking change policy**: explicit definition of what counts as
    breaking, deprecation window (1+ minor version), mandatory migration
    guide, CHANGELOG `[BREAKING]` flagging, semver bump rules.
  - **Refactoring patterns** named (Strangler Fig, Branch by Abstraction,
    Parallel Change / Expand-Migrate-Contract, Feature Toggle, Boy Scout,
    Big Bang Rewrite) with when-to-use and trade-offs. Default to
    Strangler Fig for live systems; Parallel Change for schema/API breaks;
    avoid Big Bang.
  - **Profiling & performance investigation**: tool categories (APM,
    flame graphs, memory, DB EXPLAIN, frontend devtools), measurement-first
    rule.
- Slash command table updated (added `/api-design` under Development).
- Team hierarchy diagram updated (added `technical-writer` under Leads).
- **Count consistency**: 12 agents / 23 commands synced across README,
  README.tr, CLAUDE.md, plugin.json, social-preview.svg, workflow.cast.
- **README rewritten in response to reviewer feedback**:
  - "How It Compares" table (with adjective-laden BMAD comparison) replaced
    by a neutral "When to use what" routing table — points users to BMAD
    explicitly when their need (50+ agents, enterprise greenfield) is a
    better fit there.
  - "Why Use This (and Why Not)" → "Who Is This For" — narrower, more
    honest scope. Mid-size-project / mainstream-stack focus made explicit.
  - Header tagline updated: dropped "Multilingual" as a primary
    differentiator (it's mostly Claude's existing capability), added
    "Brownfield-friendly. Scale-adaptive." which are project-specific.
  - Added explicit **early-preview** status note (v0.1.x, APIs may change).
  - "Multilingual" section renamed to **"Language Support"** and rewritten
    honestly: leverages Claude's existing multilingual ability rather than
    shipping localized templates. Localized story/sprint/retro templates
    listed as roadmap, not as shipped feature.
- **Badge cleanup** (reviewer-flagged manipulation):
  - `tests-13/13_passing` (which tested the example, not the framework)
    split into two: `frontmatter-validated` (framework) +
    `example-13/13_passing` (example).
  - `multilingual-EN|TR` badge removed — was overstating the feature.
- **Count consistency** — `11 agents, 22 commands` synced across README
  badges, header, FAQ, folder layout, `CLAUDE.md`, `plugin.json`, and
  `demo/social-preview.svg`. Previously the same file had three different
  numbers.
- `plugin.json` keywords: dropped `multilingual`, added `brownfield`
  and `scale-adaptive`.
- **`design-lead` and `product-manager` agents deepened** with the same
  framework rigor as backend-developer / security-reviewer. Previously these
  two were thin (1.3–1.4 KB) compared to peers (4.6–6.6 KB) — now ~7.6 KB
  each, with concrete frameworks instead of generic role prompts:
  - `design-lead.md` now includes Discovery Questions, Nielsen's 10
    Usability Heuristics review checklist, WCAG 2.1 Level AA mandatory
    accessibility floor (11-point checklist), Atomic Design component
    thinking (Atom/Molecule/Organism/Template), text-wireframe and
    component-spec templates with examples, frontend handoff package
    definition, and a Definition of Done.
  - `product-manager.md` now includes mandatory hypothesis-driven framing
    template, INVEST story criteria, Given/When/Then acceptance criteria
    format with bad-vs-good examples, prioritization framework comparison
    (MoSCoW, RICE, Kano, Cost of Delay, Opportunity Scoring) with
    when-to-use guidance, Now/Next/Later roadmap horizons, user segment
    discipline, separate Definition of Ready and Definition of Done
    (product perspective, distinct from engineering's DoD), and a scope
    control playbook.
  - Output format blocks expanded to surface the new frameworks in
    completion reports (e.g., `HEURISTICS`, `WCAG`, `INVEST_CHECK`,
    `DOR_CHECK`, `HYPOTHESIS`).

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
