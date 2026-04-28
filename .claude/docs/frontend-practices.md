# Frontend Practices Reference (2026)

Opinionated reference loaded by `frontend-developer`. Update quarterly; the
React / CSS / token sections move fastest.

## Stack Defaults

| Workload | Default |
|---|---|
| React product app, SSR | Next.js 15 App Router (React 19, Turbopack default) |
| React product app, SPA | Vite 6/7 + React Router v7 (SPA mode) |
| React, type-safety obsessed | TanStack Start |
| Vue product app | Nuxt 4 |
| Content / marketing / docs | Astro 5 (Server Islands + Content Layer) |
| Performance-critical, small team | SvelteKit (Svelte 5 Runes) |

**RSC rule of thumb:** if the team can't draw the server/client boundary on a whiteboard in 30 seconds, they're not ready for RSC. Static-export Next or React Router SPA is fine and unfashionable in the right way.

## State

- **Server state**: TanStack Query v5. Or RSC + server actions for Next/RR7.
- **Local state**: `useState` / `useReducer`.
- **Shared client state**: Zustand 5 (default). Jotai (atom-shaped). Redux Toolkit only on existing Redux.
- **URL state**: nuqs (Next/RR7) or TanStack Router. Default for filters, tabs, pagination, modal-open.
- **Context**: dependency injection (theme, locale, auth user). Not a state container.

**Rule:** if truth lives on a server, do not mirror into Zustand/Redux. Cache via TanStack Query (or RSC); the cache is the store.

## CSS

- **Tailwind v4 + shadcn/ui** is the 2026 default for React product apps.
- **CSS-in-JS runtime** (styled-components, Emotion) is dead for new code. Existing: match what's there.
- **Zero-runtime CSS-in-JS** (Panda CSS, vanilla-extract) only when typed tokens + recipes are genuinely needed.
- **CSS Modules** still excellent for framework-agnostic, fully-scoped styling. Pair with Open Props.
- **Forbidden in component code**: hex literals, raw `rgb()` / `hsl()`, magic spacing, inline `style={{...}}` with raw values.

## Component Architecture

- Functional components, kebab-case filenames, one component per file.
- `import type { ... }` for type-only imports.
- Headless primitives over hand-rolled a11y: **Radix** (React, gold standard), **React Aria** (Adobe, world-class a11y + locale), **Ark UI** (framework-agnostic).
- Compound components for composable APIs. shadcn copy-in over MUI/Chakra/Mantine for new product apps.
- `components/ui/` for primitives only. Everything else feature-based / colocated.
- Server-by-default in RSC apps; client at the leaves; pass serializable props.

## Testing Pyramid

| Layer | Tool | Coverage floor |
|---|---|---|
| Unit | Vitest 2/3 (+ React Testing Library) | > 80% |
| Component | Vitest browser mode + Storybook play functions | every component: Default + Loading + Error + Empty + variants |
| E2E | Playwright | smoke + happy path per release |
| Visual regression | Chromatic (Storybook) or Playwright snapshots | baseline per intentional change |
| A11y | Storybook a11y addon + axe-core | 0 violations on changed components |
| Perf | Lighthouse CI on PR | scores below budget block merge |

**Discipline:** deterministic only. No `Math.random()`, no real network, no real time (`vi.useFakeTimers()`). External deps mocked or DI-isolated.

**AI-era:** write deterministic tests for business logic, accessibility invariants, critical journeys. Use AI vision for triage of visual diffs. Never let AI assertions guard regressions alone.

## Performance Budgets

| Metric | Target | Hard ceiling |
|---|---|---|
| LCP | ≤ 2.5s | 4.0s |
| INP | ≤ 200ms | 500ms |
| CLS | ≤ 0.1 | 0.25 |
| FCP | ≤ 1.8s | 3.0s |
| Initial JS (gzip) | ≤ 170KB mobile | 300KB |
| Initial CSS (gzip) | ≤ 50KB | 100KB |
| LCP image | ≤ 200KB AVIF/WebP | 500KB |
| Lighthouse Desktop | ≥ 90 | block at < 80 |
| Lighthouse Mobile | ≥ 85 | block at < 70 |

**Images:** AVIF first, WebP fallback. Always `srcset` / `<picture>` or framework primitives. LCP image: preload + `fetchpriority="high"`, never lazy-load above the fold.

**Streaming SSR** is the default in any framework that supports it (Next, RR7, Nuxt, SvelteKit). Stream the shell, suspend slow data.

**Monitoring:** Lighthouse CI in PRs (synthetic). Vercel Speed Insights / Cloudflare Analytics / SpeedCurve / Sentry Performance for RUM. Synthetic alone lies.

## Accessibility — WCAG 2.2 AA

WCAG 2.2 (Oct 2023) is current. WCAG 2.2 additions over 2.1 to know:

- Focus appearance (2.4.11)
- Target size minimum 24×24 (2.5.8)
- Dragging movements alternative (2.5.7)
- Accessible authentication, no-CAPTCHA-only (3.3.8 / 3.3.9)
- Consistent help (3.2.6)
- Redundant entry (3.3.7)

**EAA (European Accessibility Act):** enforcement since June 28 2025. Maps to EN 301 549 → WCAG 2.1 AA (with 2.2 increasingly expected). Fines vary by member state. For EU-facing products, 2.2 AA is legal floor.

**Tools:**
- axe DevTools (manual)
- Storybook a11y addon (per-component)
- Lighthouse a11y (CI sanity — catches ~30%)
- Pa11y (site-wide automated scans)
- Manual: keyboard-only, NVDA / VoiceOver / TalkBack, 200% zoom, prefers-reduced-motion

**Library:** ARIA Authoring Practices Guide patterns are canonical. Use Radix / React Aria / Ark — don't reinvent.

## Design Tokens — DTCG Format

W3C Design Tokens Community Group spec stabilized 2025.10. Use `*.tokens.json`:

```json
{
  "color": {
    "background": {
      "surface": { "$value": "{color.gray.50}", "$type": "color" }
    }
  }
}
```

**Three tiers:** primitive → semantic → component. Code consumes semantic + component only.

**Modes** (light/dark, density, brand) are values on semantic tokens, **not separate token sets**.

**Pipeline:** Figma Variables → DTCG JSON → Style Dictionary v4 → CSS variables / Tailwind / native platforms. Tokens Studio (Figma plugin), Specify / Supernova (commercial pipelines).

**OKLCH** preferred over HSL/HEX. Single `--brand-hue` drives whole palette via OKLCH math; predictable contrast across shades.

## Forms

React Hook Form + Zod for schema-driven forms. Server-side: same Zod schema validated again. Don't trust the client.

Optimistic UI for high-success actions: React 19 `useOptimistic`. Always handle rollback.

## Internationalization

- ICU MessageFormat for plurals / dates / numbers.
- RTL: `dir="rtl"` on root or section; CSS logical properties (`margin-inline-start`, not `margin-left`).
- Icon mirroring: back/forward arrows mirror; checkmarks don't.
- Text expansion: budget +30% width for German, +25% for Arabic. Test at design time.
- Don't bake text into images.

## Motion

- Material 3 / Apple HIG easings preferred.
- Standard easing: `cubic-bezier(0.2, 0, 0, 1)` (entrances). Exits: `cubic-bezier(0.4, 0, 1, 1)`. Avoid linear except continuous motion.
- Duration tiers: 150ms (micro) / 250ms (transitions) / 400ms (large). Faster than feels right is usually correct.
- Always honor `prefers-reduced-motion`. Replace transforms with cross-fade or instant.
- View Transitions API for route changes when supported.

## The 8 States Every Screen Has

1. Nothing — first-time, no data ever (teach + 1 CTA)
2. Loading
3. Partial (some loaded, more loading)
4. Ideal / loaded (the happy path designers usually draw)
5. One (exactly one item — looks weird if you skip)
6. Too much (overflow / virtualization)
7. Error (recoverable)
8. Stale / offline

If a component covers fewer than 8 stories, it's not done.

**Skeleton vs spinner:** skeleton when layout is known and load > 400ms. Spinner for indeterminate / short / unknown-shape. Nothing if it'll resolve under ~150ms.

**Optimistic UI** for actions where server is highly likely to succeed (likes, toggles, reorders).

**Offline-first** when commute / factory / plane / low-connectivity is the use case: Workbox or framework-native PWA, IndexedDB via `idb-keyval` / Dexie, sync engines like Replicache / Yjs / ElectricSQL / PowerSync.

## MCP Toolbelt

Use these when the project has them wired:

| Server | Use for |
|---|---|
| Playwright MCP (Microsoft) | Drive a browser, accessibility tree, write tests, reproduce bugs |
| Chrome DevTools MCP (Google) | Console, network, performance trace, Lighthouse, HAR, computed styles |
| Figma Dev Mode MCP | Read frames, variables, components, code-connect map |
| Storybook MCP (Chromatic) | Look up existing components and variants |
| Context7 (Upstash) | Version-pinned library docs (kills hallucinated APIs) |
| shadcn registry MCP | Install primitives without leaving the agent loop |

## AI-Assisted Workflows

- **Storybook + AI** is good: AI generates baseline stories from props/types; AI screenshots stories headlessly and runs vision review on PR.
- **v0 / Lovable / bolt-style codegen** is useful for prototypes, internal tools, scaffolds. Treat output as junior PR — review accordingly. Often poor a11y, inconsistent token use, fragile state, no tests.
- **Design-to-code** (Anima, Locofy, Builder.io Visual Copilot) better in 2025-26 but still imperfect. Best for low-interactivity marketing pages with mapped components.

## Anti-Patterns to Avoid

- Generic ChatGPT-blue / indigo on every primary CTA without brand reason
- Gradient text (especially purple → blue)
- Glassmorphism on every card
- Identical 3-up card grids
- Hero-metric layouts ("12,847 users trust us") with no source
- Nested cards (card inside card inside card)
- Stock-photo people staring at laptops
- `'use client'` on the entire tree
- Mirroring server state into a client store
- Custom `<Modal>` / `<Combobox>` / `<Tabs>` instead of Radix / React Aria
- 100% test coverage chase (smell — usually testing implementation not behavior)
- `Math.random()` / real time / real network in unit tests
