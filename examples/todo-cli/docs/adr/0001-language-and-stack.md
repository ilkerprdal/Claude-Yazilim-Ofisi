# ADR 0001 — Language and Stack

**Status**: Accepted
**Date**: 2026-04-12
**Deciders**: tech-director, with user approval

## Context

We need to pick a language for a CLI that:
- Starts in < 200 ms (NFR-001)
- Runs cross-platform (NFR-004)
- Has minimal dependencies (NFR-006)
- Is approachable for the target user (developers)

## Options

| Option | Cold start | Cross-platform | Dependencies |
|--------|-----------|----------------|--------------|
| Python 3.11 | ~50ms | ✅ | stdlib + Click |
| Go | ~5ms | ✅ (single binary) | none |
| Node.js | ~150ms | ✅ | npm + click-equivalent |
| Rust | ~3ms | ✅ (single binary) | crates |

## Decision

**Python 3.11**.

Reasoning:
- Target users (developers in 2026) already have Python installed
- Cold start of 50ms easily beats the 200ms NFR
- stdlib `sqlite3` removes a major dependency
- Pure-Python = MIT-friendly, no compilation step
- Click is the most ergonomic CLI framework for the developer experience

Rust/Go would give faster startup but add a build pipeline and
binary distribution that's overkill for a personal todo CLI.

## Consequences

- (+) Easy install: `pip install`
- (+) Easy contribution: any developer can read it
- (-) Requires Python on the user's machine (acceptable for our audience)
- (-) Slower than a compiled binary by ~10x — still well under budget
