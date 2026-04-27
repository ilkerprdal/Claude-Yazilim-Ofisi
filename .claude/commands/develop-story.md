---
description: "Implement a story end-to-end — load context, route to right developer, write code and tests. Triggers on 'develop story X', 'implement story 003', 'work on this task', 'hikaye gelistir'."
allowed-tools: Read, Glob, Grep, Write, Edit, Bash, Task
argument-hint: "[story-id or slug, e.g. 003 or 003-login]"
---

# /develop-story

Input: story slug (e.g. `/develop-story 003-login`).

### Flow

1. **Load context**
   - Story file
   - Related architecture section
   - ADR references
   - Existing files to be touched

2. **Route to right agent**
   - Backend / API / DB → `backend-developer`
   - UI / component / screen → `frontend-developer`
   - Full-stack → backend first, then frontend (or parallel)

3. **Implementation protocol** (on the agent's side)
   - Propose file list + signatures
   - Get approval
   - Code + test together
   - Run the test, show result
   - Check off acceptance criteria one by one

4. **Closure**
   - Set story **Status** to `Review`
   - Suggest `/code-review`
