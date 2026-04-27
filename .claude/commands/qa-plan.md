---
description: "Generate a test plan for a sprint or feature. Triggers on 'prepare test plan', 'QA plan', 'test strategy', 'what to test'."
allowed-tools: Read, Glob, Grep, Write, Edit
---

# /qa-plan

Engage `qa-lead`.

### Input

- Story files (sprint stories or single feature)
- Related GDD / spec / architecture references

### Output

`production/qa/plan-[date].md`:

```markdown
# Test Plan — [Sprint / Feature]

## Scope
[Which stories]

## Automated Test Requirements
| Story | Test Type | File Location |
|-------|-----------|---------------|
| 003   | Unit      | tests/unit/auth/ |

## Manual Test Scenarios
1. [Step-by-step scenario]
2. ...

## Smoke Test Coverage
- [Critical path list]

## Acceptance Evidence
- [What's needed for each story to be Status=Done]
```

Don't write the plan draft without user approval.
