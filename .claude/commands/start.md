---
description: "Onboard into the project — detect prior AI context, then tech stack, then suggest the next command. Triggers on 'where do I start', 'help me begin', 'getting started', 'baslat', 'başla'."
allowed-tools: Read, Glob, Grep
---

# /start

Three steps: prior context check → tech stack detection → suggest next.

### Step 0: Prior Context Check

Scan for AI-tool context files. If any exist, suggest **`/takeover`** then stop:

- `context.md`, `CONTEXT.md`, `MEMORY.md`, `NOTES.md`
- `.cursorrules`, `.cursor/rules/*`, `.windsurfrules`, `.windsurf/rules/*`
- `.github/copilot-instructions.md`
- `AGENTS.md`, `STATE.md`

If found:
```
Detected prior AI context files:
- context.md
- .cursorrules

Run /takeover first to import them, then come back to /start.
```

If not found, proceed.

### Step 1: Tech Stack Detection

Scan project root and tell the user what you saw:

| File | Detection |
|---|---|
| `package.json` | Node — scan deps for next/react/vue/express/nest/... |
| `requirements.txt` / `pyproject.toml` | Python — fastapi/django/flask |
| `pom.xml` / `build.gradle` | Java — spring/quarkus |
| `Cargo.toml` | Rust |
| `go.mod` | Go |
| `composer.json` | PHP — laravel/symfony |
| `Gemfile` | Ruby — rails |
| `*.csproj` | .NET |
| `Dockerfile` / `docker-compose.yml` | Container / multi-service |
| `.github/workflows/` | CI present |

Summarize:
```
What I detected:
- Language: [..]
- Framework: [..]
- DB: [..]
- CI: [..]

Correct?
```

### Step 2: Memory + State

If `.claude/memory/` exists, list categories present.
If `production/session-state/active.md` exists, summarize last state.

### Step 3: Suggest Next

| State | Suggestion |
|---|---|
| Empty repo, no code | Describe what you want to build → cto picks stack |
| Existing code, no docs | `/feature` for the next change you want |
| Open bug reports in `production/qa/bugs/` | `/bug-fix [id]` |
| About to release | `/release-check` |
| Just want a one-liner change | `/quick-fix` |

### Output

```
STATUS: COMPLETED
DETECTED_STACK: [stack summary]
MEMORY_LOADED: [count]
SUGGESTED_NEXT: [recommended command]
```
