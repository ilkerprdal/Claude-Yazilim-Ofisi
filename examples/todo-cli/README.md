# todo-cli — Software Office Worked Example

A complete, end-to-end example showing what a project looks like after
running through the Software Office workflow: `/idea` → `/analyze` →
`/architecture` → `/create-stories` → `/sprint-plan` → `/develop-story` →
`/code-review` → `/qa-plan` → `/retro`.

**This is not the source code of a real product.** It's a teaching
artifact — every doc and code file shows what an agent would produce
if you'd run the workflow yourself.

## What's in here

```
docs/
  product/concept.md            ← /idea output
  analysis/requirements.md      ← /analyze output (FR + NFR)
  architecture/architecture.md  ← /architecture output
  adr/
    0001-language-and-stack.md
    0002-storage-format.md
    0003-cli-framework.md       ← ADRs from /architecture
production/
  backlog.md                    ← /backlog output
  stories/
    001-add-task.md
    002-list-tasks.md
    003-complete-task.md        ← /create-stories output
  sprints/
    S01-2026-04-15.md           ← /sprint-plan output
  retros/
    S01.md                      ← /retro output
src/                            ← actual implementation
tests/                          ← actual tests
```

## How to read this

Open files in this order to follow the agent narrative:

1. **`docs/product/concept.md`** — What's the product?
2. **`docs/analysis/requirements.md`** — What must it do? (FR + NFR)
3. **`docs/architecture/architecture.md`** — How will we build it?
4. **`docs/adr/`** — Why these technical choices?
5. **`production/stories/001-add-task.md`** — How is one feature scoped?
6. **`production/sprints/S01-2026-04-15.md`** — Sprint planning shape
7. **`src/commands/add.py`** — What the developer agent produced
8. **`tests/unit/test_add.py`** — Test that proves it works
9. **`production/retros/S01.md`** — What we learned

## Run the actual code

```bash
cd examples/todo-cli
python -m venv .venv && source .venv/bin/activate    # Linux/Mac
# .\.venv\Scripts\activate                            # Windows
pip install click pytest
pytest                                                # all tests pass
python -m todo_cli add "buy milk"
python -m todo_cli list
```

## What's intentionally minimal

- 3 stories (real sprint would have 5-8)
- 1 sprint, 1 retro
- No frontend (CLI only — keeps the example focused)
- No CI/CD (would be in a 2nd sprint)

The point isn't to ship a polished CLI — it's to show **what the artifacts
look like** when you let Software Office structure your work.
