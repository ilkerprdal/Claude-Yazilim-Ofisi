---
description: "Smart help — looks at project state and suggests the most logical next command + lists all commands. Triggers on 'help', 'what can I do', 'what's next', 'yardim', 'yardım'."
allowed-tools: Read, Glob, Grep
---

# /help

Two parts: **smart suggestion** + **all commands**.

### Part 1: Smart Suggestion (priority)

Look at project state and suggest **1-3 most logical commands**:

| State | Suggestion |
|-------|------------|
| Prior AI context files exist (context.md, .cursorrules, etc.) | `/takeover` (first) |
| Empty project | `/start` or `/idea` |
| Concept exists, no analysis | `/analyze` |
| No architecture | `/architecture` |
| No stories | `/create-stories` |
| No sprint | `/sprint-plan` |
| Sprint active, half stories in progress | `/standup` or `/develop-story [next]` |
| Sprint active, most stories in `Review` | `/code-review` |
| Code exists, no tests | `/qa-plan` |
| Open bugs (`production/qa/bugs/*.md`) | `/bug-fix` |
| Sprint nearing end | `/retro` or `/standup` |
| Release approaching | `/release-check` |
| Multiple conflicting opinions | `/consult` |

Format:
```
📍 Project state: [summary]

💡 Recommended next step:
   /command [args] — [why]

Alternative:
   /other-command — [why]
```

### Part 2: All Commands

```
WORKFLOW:
/start → /idea → /analyze → /architecture → /create-stories
                                                ↓
                                         /sprint-plan
                                                ↓
                              /develop-story → /code-review
                                                ↓
                                            /qa-plan
                                                ↓
                                         /release-check
```

| Command | What It Does | Agent |
|---------|--------------|-------|
| **Onboarding** | | |
| `/takeover` | Import existing project context (context.md, .cursorrules, etc.) | — |
| `/start` | Stage + tech stack detection, route | — |
| `/help` | This screen (with context-aware suggestion) | — |
| **Design** | | |
| `/idea` | Concept doc | product-manager |
| `/analyze` | Requirements / existing system analysis | business-analyst |
| `/architecture` | Technical architecture + ADRs | tech-director |
| **Sprint** | | |
| `/create-stories` | Generate stories | product-manager |
| `/backlog` | Backlog refinement | scrum-master |
| `/sprint-plan` | Sprint planning | scrum-master |
| `/standup` | Daily status | scrum-master |
| `/retro` | Sprint retrospective | scrum-master |
| **Development** | | |
| `/develop-story` | Implement a story | backend/frontend |
| `/code-review` | Code review | engineering-lead |
| **QA & Security** | | |
| `/qa-plan` | Test plan | qa-lead |
| `/bug-report` | Create structured bug report | qa-lead |
| `/bug-fix` | QA→Dev→QA bug fix loop | bug owner |
| `/security-review` | STRIDE + OWASP audit | security-reviewer |
| **Decision / Knowledge** | | |
| `/consult` | Multi-agent consultation (party mode) | (panel) |
| `/memory` | Manage project learnings | — |
| `/release-check` | Pre-release readiness | tech-director |

### Agents (11)

**Directors**: tech-director, product-manager
**Leads**: engineering-lead, qa-lead, design-lead, business-analyst, scrum-master, security-reviewer
**Specialists**: backend-developer, frontend-developer, devops

### Output

```
STATUS: COMPLETED
DETECTED_STATE: [summary]
SUGGESTED: [command]
ALTERNATIVES: [if any]
```
