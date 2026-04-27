# Coding Standards

## General

- Public APIs include doc comments
- No magic numbers — extract to config or constants
- Every public function must be testable (DI, not singleton)
- Commit messages reference story ID
- Verification-driven: test first, then implement (for logic stories)

## Naming

Follow language/framework convention. After project setup, customize in
`CLAUDE.md`.

## Test Standards

| Story Type | Required Evidence | Gate |
|------------|-------------------|------|
| Logic | Unit test | BLOCKING |
| Integration | Integration test or manual walkthrough | BLOCKING |
| UI | Manual walkthrough or interaction test | ADVISORY |
| Config / data | Smoke test | ADVISORY |

### Test Rules

- Deterministic — no random seeds, no time-dependent assertions
- Each test sets up and tears down its own state
- No inline magic numbers (except boundary value tests)
- External dependencies mocked or DI-isolated

## Security

- Secrets not in code, use `.env` and a secret manager
- Validate user input always
- Basic SQL injection, XSS, CSRF checks
- `.env` not committed; `.env.example` is committed

## Documentation

- Every major decision → `docs/adr/NNNN-title.md`
- API change → `docs/api/` update
- Breaking change → CHANGELOG entry
