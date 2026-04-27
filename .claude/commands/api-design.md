---
description: "Schema-first API design — produces OpenAPI / GraphQL SDL / .proto from requirements before implementation. Engineering-lead drives, backend-developer reviews, qa-lead reviews testability. Triggers on 'design API', 'API contract', 'endpoint design', 'API tasarla'."
allowed-tools: Read, Glob, Grep, Write, Edit, Task
argument-hint: "[short feature/endpoint description]"
---

# /api-design

Schema-first design of an API surface. **Schema before code, contract
before implementation.** The schema is the single source of truth that
backend, frontend, and QA all agree on before anyone writes implementation.

### When to use

Use when:
- Adding a new endpoint, resource, or RPC method
- Modifying an existing public API surface
- Designing a new microservice's external contract
- Splitting a monolith and defining the seam

If the change is **internal-only** (private function, internal module): skip
this command — design at code-review time is enough.

### Steps

1. **Acknowledge scope** to user:
   > "Schema-first API design path. Output: OpenAPI / GraphQL SDL / .proto
   > schema for review BEFORE any implementation. backend-developer and
   > qa-lead will both review the schema. Confirm? (y/n)"

2. **Detect API style** (delegate stack detection to `engineering-lead`)
   - REST + JSON → OpenAPI 3.x (`docs/api/openapi.yaml`)
   - GraphQL → SDL (`docs/api/schema.graphql`)
   - gRPC → `.proto` files
   - AsyncAPI for event-driven (Kafka, NATS, MQTT)
   - If unclear, ask user before assuming.

3. **Gather requirements** (delegate to `business-analyst` if requirements vague)
   - Who calls this? (consumer profile)
   - What's the user-facing job?
   - Required fields vs. optional vs. computed-server-side
   - Error scenarios (which 4xx / 5xx, with what shape)
   - Latency expectation (p95 target — informs sync vs. async)
   - Volume expectation (RPS — informs pagination, rate-limiting)

4. **Draft the schema** (`engineering-lead` is primary author)
   - Resource modeling: nouns, plural, hierarchical (`/orders/{id}/items`)
   - HTTP verbs: GET (read), POST (create), PUT (replace), PATCH (partial), DELETE
   - Response envelope: stable (`{ data, meta, errors }`)
   - Pagination: cursor-based by default (`?cursor=abc&limit=50`)
   - Versioning strategy: URL (`/v1/`) or header — pick one project-wide
   - Naming convention: snake_case OR camelCase (consistent project-wide)
   - Auth: declared at endpoint level (Bearer / API-key / OAuth scope)
   - Rate limiting: declared in `x-ratelimit-*` headers spec

5. **Apply OWASP API Security Top 10** (mandatory schema-time check)
   - **API1: Broken Object Level Authz** — every resource access requires owner check
   - **API2: Broken Auth** — auth scheme declared, token expiry defined
   - **API3: Broken Object Property Level Authz** — sensitive fields gated by scope
   - **API4: Unrestricted Resource Consumption** — pagination + rate limit declared
   - **API5: Broken Function Level Authz** — admin endpoints separated by path/role
   - **API6: Unrestricted Access to Sensitive Business Flows** — multi-step flows protected
   - **API7: SSRF** — external URL params validated/whitelisted
   - **API8: Security Misconfiguration** — CORS, security headers declared
   - **API9: Improper Inventory Management** — schema versioned, deprecated endpoints marked
   - **API10: Unsafe Consumption of APIs** — third-party API contracts pinned

6. **Backend feasibility review** (delegate to `backend-developer`)
   - Can current stack implement this efficiently?
   - DB schema impact?
   - N+1 risk in proposed shape?
   - Caching opportunity?

7. **QA testability review** (delegate to `qa-lead`)
   - Is the schema **contract-testable**? (Pact / Schemathesis / OpenAPI tests)
   - Are error cases enumerable?
   - Can a contract test be generated from the schema?

8. **Frontend consumer review** (if user-facing API, delegate to `frontend-developer`)
   - Does the response shape match component data needs?
   - Pagination model fit for UI patterns (infinite scroll vs. paged)?
   - Optimistic update feasibility?

9. **Security review** (only if endpoint touches auth/PII/payments/files,
   delegate to `security-reviewer`)
   - STRIDE pass on the new surface
   - Sensitive data classification
   - Audit log requirements

10. **Generate companion artifacts**
    - **Contract test stub** (`tests/contract/<endpoint>.test.*`)
    - **Example requests/responses** in schema (for docs rendering)
    - **CHANGELOG entry** under `[Unreleased]` → Added (or BREAKING if modifying)
    - **ADR** if a new convention is being introduced (versioning, error envelope, etc.)

11. **Final verdict** — `engineering-lead` owns the call:
    - APPROVE: schema goes to implementation; backend-developer can start.
    - REQUEST_CHANGES: revise based on review feedback.
    - BLOCK: needs tech-director (architectural conflict) or product-manager (scope conflict).

### Rules

- **No implementation code in this flow.** This command stops at schema +
  contract test stub + companion docs. Implementation happens in
  `/develop-story` or `/feature` after schema is approved.
- **No silent breaking changes.** If modifying existing schema, declare
  breaking-vs-non-breaking explicitly; if breaking, draft migration guide.
- **Schema-first means schema-first.** If implementation already started,
  pause it; design the schema, then resume.
- **One schema source of truth.** Don't hand-write API docs that the
  schema doesn't generate. Render docs from schema.

### Output Format

```
STATUS: COMPLETED | BLOCKED | NEEDS_INPUT
SCOPE: API_DESIGN
API_STYLE: REST_OPENAPI | GRAPHQL_SDL | GRPC_PROTO | ASYNCAPI
ENDPOINTS_DESIGNED: [list — method + path or operation]
SCHEMA_FILE: [path]
BREAKING: YES | NO
MIGRATION_GUIDE: [path if breaking, else NOT_NEEDED]
OWASP_API_TOP10: PASS | CONCERNS ([items])
BACKEND_FEASIBILITY: PASS | CONCERNS ([items])
QA_TESTABILITY: PASS | CONCERNS
CONTRACT_TEST_STUB: [path or NOT_GENERATED]
ADR_NEEDED: YES ([path]) | NO
CHANGELOG_ENTRY: ADDED | NOT_NEEDED
SECURITY_REVIEW: REQUESTED | NOT_APPLICABLE | COMPLETED
VERDICT: APPROVE | REQUEST_CHANGES | BLOCK
NEXT: [recommended step — usually `/develop-story` or `/feature`]
```
