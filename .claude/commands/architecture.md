---
description: "Technical architecture document — system boundaries, data flow, technology choices, ADRs. Triggers on 'design architecture', 'technical design', 'pick the stack', 'ADR', 'mimari'."
allowed-tools: Read, Glob, Grep, Write, Edit, WebSearch, AskUserQuestion
---

# /architecture

Engage `tech-director`. Read `docs/product/concept.md` if present.

### Sections to Fill

1. **Overview** — 1 paragraph system summary
2. **Components** — services, layers, modules
3. **Data Model** — main entities and relationships
4. **Integrations** — external services, APIs
5. **Technology Choices** — language, framework, DB (rationale each)
6. **Security** — auth, authz, secrets management
7. **Deployment** — environments, CI/CD, monitoring
8. **Open Decisions** — yet-unresolved ADRs

### Flow

- For each section, generate 2-3 options with pros/cons
- As user picks, write to `docs/architecture/architecture.md`
- For major decisions, create `docs/adr/NNNN-title.md`

### Rules

- Don't reference unavailable technologies — pick and write
- Track unfinished topics in "Open Decisions", not as TODOs
