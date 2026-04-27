---
description: "Multi-agent consultation for complex decisions — 'party mode'. User is moderator. Triggers on 'let's discuss', 'different opinions', 'architectural decision', 'X vs Y'."
allowed-tools: Read, Glob, Grep, Task, AskUserQuestion
argument-hint: "[topic — e.g. 'sql vs nosql', 'monorepo vs polyrepo']"
---

# /consult

For complex / multi-faceted decisions, bring multiple agents to the table
**simultaneously**. User moderates, agents are experts.

### When to Use

- Architectural decisions (DB, language, framework choice) — tech-director + engineering-lead + devops
- Scope decisions — product-manager + business-analyst + scrum-master
- Performance / security tradeoff — tech-director + qa-lead + devops
- General: **more than 2 agents** care

### Flow

1. **Get topic** (from arg or ask user)

2. **Pick the right panel** — propose, validate:

   | Decision Type | Suggested Panel |
   |---------------|-----------------|
   | Tech selection | tech-director + engineering-lead + devops |
   | Scope / priority | product-manager + business-analyst + scrum-master |
   | UX vs technical | design-lead + frontend-developer + tech-director |
   | Release | tech-director + qa-lead + devops |

3. **Each agent gives their view** (parallel Task calls):
   - Their recommendation
   - Strength
   - Risk / objection

4. **Surface conflicts**
   - When agents disagree, show as a table:
     ```
     | Topic           | tech-director | engineering-lead | devops |
     | DB choice       | PostgreSQL    | PostgreSQL       | DynamoDB|
     | Rationale       | ACID          | team familiarity | scale   |
     ```

5. **User decides**
   - "I pick X" → write rationale to an ADR
   - "Still undecided" → prepare more questions

### Rules

- Agent **does not own the decision** — don't write files without user approval
- Conflicts are highlighted, not hidden
- If discussion stalls, suggest "let's prototype" alternative (e.g. `/prototype`)

### Output

```
STATUS: COMPLETED
PANEL: [participating agents]
TOPIC: [discussed]
RECOMMENDATIONS:
  - [agent-1]: [summary] — rationale
  - [agent-2]: [summary] — rationale
  - [agent-3]: [summary] — rationale
CONFLICT: YES | NO
USER_DECISION: [if any]
WROTE: [ADR path if any]
NEXT: [recommended step]
```
