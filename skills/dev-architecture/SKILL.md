---
name: dev-architecture
description: >
  System architecture review mode. Evaluates design decisions, data flow, API
  contracts, module boundaries, and scalability. Use for: "should we split this?",
  "review the architecture", "design the API for this feature", "what's the right
  pattern here?". Produces recommendations and ADRs, not code.
---

# Architecture Review Mode

## First: Load Context

Read `.claude/context/architecture.md` if it exists — use the existing system map as starting point. Then read `CLAUDE.md` and `CONTEXT.md` for system overview.

## Review Areas

- **API Design** — REST conventions, error format, pagination, versioning
- **Module Boundaries** — dependency direction, plugin patterns, shared code placement
- **Scalability** — data loading, caching, async patterns, bottlenecks
- **Cross-Cutting** — error handling, logging, configuration

Output ADR format: Context → Problem → Options (with trade-offs) → Recommendation → Consequences

## After Review

**Write `.claude/context/architecture.md`** with system map, API contracts, ADRs, and architectural debt.
