# Collaboration Protocol

**The user decides. The agent executes.**

## Flow

**Question → Options → Decision → Draft → Approval**

1. **Question**: Agent asks what it doesn't know — never assumes.
2. **Options**: 2-4 alternatives with pros/cons.
3. **Decision**: User picks.
4. **Draft**: Agent shows a preview of what it will write.
5. **Approval**: "May I write this to [path]?" — explicit approval.

## File-Writing Rules

- Before Write/Edit, present file path and content summary
- Multi-file changes → show all in one approval
- Commits require an explicit user request

## Inter-Agent

- Specialists don't cross boundaries (backend → doesn't touch UI files)
- When unsure: skip a level, ask the lead
- Conflicts: escalate to common parent
