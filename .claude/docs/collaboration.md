# Collaboration Protocol

**The user decides. The agent executes.** But not at the cost of grinding to
a halt over every keystroke.

## Two modes

### 🚀 Speed mode (default — solo / small team)

For routine work, agents proceed in **scope-batched** fashion:

1. **Plan**: agent lists what it intends to do — files to write, commands to run
2. **One approval**: user OKs the whole batch in a single round-trip
3. **Execute**: agent does the work without further per-file prompts
4. **Report**: 1-3 line summary at the end (status + next step)

If scope expands mid-execution, agent pauses and re-batches. Otherwise: don't
stop to ask.

### 🐢 Verbose mode (high-stakes, complex changes)

For cross-cutting decisions, breaking changes, or when the user says
"verbose mode", "step by step", or "yavaş gidelim":

**Question → Options → Decision → Draft → Approval**

1. **Question**: agent asks what it doesn't know — never assumes
2. **Options**: 2-4 alternatives with pros/cons
3. **Decision**: user picks
4. **Draft**: agent shows preview of what it will write
5. **Approval**: explicit per-file or per-section approval

## Hard gates (always require explicit per-op approval)

Speed mode does NOT bypass these:

- **Destructive**: `rm`, force-push, branch delete, file delete in `src/`/`tests/`
- **Schema/migration**: DB migration scripts (both forward and rollback)
- **Secrets**: any read or write to `.env`, key files, credential paths
- **Breaking public API**: changes to documented external contracts
- **Production deploy**: any deploy or release tag operation
- **Git history rewrite**: rebase --force, filter-branch

## Output rules

- **Default**: agent reply ends with `STATUS: COMPLETED — next: <step>` (or
  similar single line). No 15-line block.
- **On failure / concerns / blocked**: full structured output block as
  defined per-agent. The block is for diagnosis, not happy path.
- **Verbose mode**: full block always.

## File-Writing Rules

- One coherent change set = one approval. List all files up front.
- New files outside the planned set → re-batch (don't sneak files in).
- Multi-file refactors: show file list + intent; user OKs once; proceed.
- Commits require an explicit user request — never auto-commit.

## Inter-Agent

- Specialists stay in their domain (backend → no UI files; frontend → no DB)
- When unsure: skip a level, ask the lead
- Conflicts: escalate to common parent (lead → director)
- In speed mode, orchestrator may go directly specialist → specialist for
  contract handoffs (e.g., backend → frontend) without lead in the loop,
  unless the change is architecturally significant
