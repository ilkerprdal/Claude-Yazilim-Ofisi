---
description: "Smart help — looks at project state and suggests the next logical command + lists all commands. Triggers on 'help', 'what can I do', 'what's next', 'yardim', 'yardım'."
allowed-tools: Read, Glob, Grep
---

# /help

Two parts: smart suggestion + the full command list.

### Part 1: Smart Suggestion

Look at project state and suggest 1–2 commands:

| State | Suggestion |
|---|---|
| Prior AI context files exist (context.md, .cursorrules, etc.) | `/takeover` |
| Empty / new project | `/start` |
| Open bug reports in `production/qa/bugs/` | `/bug-fix [id]` |
| Active feature in progress (`production/qa/spec-*.md` recent) | resume `/feature` for that slug |
| Release approaching | `/release-check` |
| Small change wanted | `/quick-fix` |
| Anything else | `/feature` |

Format:
```
Project state: [summary]

Recommended:
   /command [args] — [why]

Alternative:
   /other-command — [why]
```

### Part 2: All Commands

```
DEFAULT FLOW (most work):
/feature → researcher → qa → tech-lead → developer(s) → tech-lead → qa → done

LIGHT PATH:
/quick-fix → developer + tech-lead glance

BUG FLOW:
/bug-fix → researcher → developer → qa
```

| Command | What | Drives |
|---|---|---|
| **Onboarding** | | |
| `/start` | Detect stack + state, suggest next | — |
| `/takeover` | Import prior AI context files | — |
| `/help` | This screen | — |
| **Build** | | |
| `/feature` | Default flow for any change | researcher → qa → tech-lead → developer |
| `/quick-fix` | Tiny change, skip the flow | developer + tech-lead |
| `/bug-fix` | Locate, fix, regression-test | researcher → developer → qa |
| **Gates** | | |
| `/security-review` | On-demand security audit | security-reviewer |
| `/release-check` | Pre-release GO/NO-GO | cto |
| **Knowledge** | | |
| `/memory` | View / add project learnings | — |

### Agents (7)

**Top:** cto (decisions, on-call)
**Flow:** researcher → qa → tech-lead → developer
**On-call:** security-reviewer, devops

The flow runs without cto / security / devops by default. They're invoked
only when their trigger fires (architectural call, risk flag, infra change,
release sign-off).

### Output

```
STATUS: COMPLETED
DETECTED_STATE: [summary]
SUGGESTED: [command]
ALTERNATIVES: [if any]
```
