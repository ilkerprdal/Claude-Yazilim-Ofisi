---
description: "Smart onboarding — auto-detects project stage and tech stack, then routes to the right command. Triggers on 'where do I start', 'help me begin', 'getting started', 'baslat', 'başla'."
allowed-tools: Read, Glob, Grep, AskUserQuestion
---

# /start

Auto-detect project state, then route.

### Step 0: Prior Context Check (Takeover)

First scan for AI-tool context files. If any exist, suggest **`/takeover`** then stop:

- `context.md`, `CONTEXT.md`, `MEMORY.md`, `NOTES.md`
- `.cursorrules`, `.cursor/rules/*`, `.windsurfrules`, `.windsurf/rules/*`
- `.github/copilot-instructions.md`
- `AGENTS.md`, `STATE.md`

If found:
```
⚠️ Detected prior AI context files:
- context.md
- .cursorrules

Run `/takeover` first to import them, then come back to `/start`.
```

If not found, proceed to Step 1.

### Step 1: Project Stage Detection

Check in this order:

| Indicator | Stage | Suggestion |
|-----------|-------|------------|
| Nothing exists | Empty project | Suggest `/idea` |
| `docs/product/concept.md` only | Idea phase | Suggest `/analyze` |
| `docs/analysis/` exists, no architecture | Analysis phase | Suggest `/architecture` |
| `docs/architecture/architecture.md`, no stories | Architecture phase | Suggest `/create-stories` |
| `production/stories/*.md` exists, no sprint | Backlog ready | Suggest `/sprint-plan` |
| Active sprint (`production/sprints/`) | In sprint | Suggest `/standup` |
| `src/` exists but no project docs | **Existing codebase** | Suggest `/analyze` (existing system mode) |
| `production/session-state/active.md` populated | Continuing | Read `active.md`, summarize state |

### Step 2: Tech Stack Detection

Scan project root for these — tell user, validate:

| File | Detection |
|------|-----------|
| `package.json` | Node.js → scan `dependencies` for framework (next/react/vue/express/nest/...) |
| `requirements.txt` / `pyproject.toml` | Python → fastapi/django/flask |
| `pom.xml` / `build.gradle` | Java → spring/quarkus |
| `Cargo.toml` | Rust |
| `go.mod` | Go |
| `composer.json` | PHP → laravel/symfony |
| `Gemfile` | Ruby → rails |
| `.csproj` | .NET |
| `Dockerfile` | Container |
| `docker-compose.yml` | Multi-service |
| `.github/workflows/` | CI present |

Summarize:
```
What I detected:
- Language: Python 3.11
- Framework: FastAPI 0.110
- DB: PostgreSQL (from docker-compose)
- CI: GitHub Actions

Correct?
```

### Step 3: Load Memory

If `.claude/memory/` exists, summarize lessons and continue.

### Step 4: Route

Based on detected stage, recommend **one** command. Offer alternatives if asked.

### Rules

- Don't assume — state your detections, validate
- Multiple stages visible at once → ask the user
- Can't detect → "I couldn't parse the folder structure, can you tell me manually?"

### Output

```
STATUS: COMPLETED
DETECTED_STAGE: [stage]
DETECTED_STACK: [stack summary]
MEMORY_LOADED: [count]
SUGGESTED_NEXT: [recommended command]
```
