# ADR 0003 — CLI Framework

**Status**: Accepted
**Date**: 2026-04-12
**Deciders**: tech-director

## Context

We need a Python CLI framework that:
- Handles subcommands (add, list, done)
- Validates inputs cleanly
- Generates `--help` automatically
- Doesn't hurt our 200ms startup budget

## Options

- **argparse** (stdlib) — zero dep, but verbose
- **Click** — popular, decorator-based, ~30ms import time
- **Typer** — modern, FastAPI-like, but pulls Click + extras
- **fire** — too magic, poor UX for typed inputs

## Decision

**Click**.

Reasoning:
- Decorator API is concise and readable
- Built-in input validation (`type=`, `required=`)
- Auto-generated `--help` is good
- ~30ms import time leaves us well under 200ms budget
- Ubiquitous in Python tooling — low surprise factor

## Consequences

- (+) Adds 1 dependency — acceptable trade-off for ergonomics
- (-) `argparse` would be zero-dep but at the cost of more boilerplate
