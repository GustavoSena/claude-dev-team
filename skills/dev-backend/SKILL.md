---
name: dev-backend
description: >
  Backend development mode. Activates backend-specialist thinking for server-side
  code, APIs, data models, and integrations. Use for: "add an endpoint", "fix this
  data source", "optimize the async flow", "add a new model". For full-stack tasks
  that also need frontend changes, use /dev-team instead.
---

# Backend Development Mode

## First: Load Context

Read `.claude/context/backend.md` if it exists — skip re-exploration of known files and patterns. Then read `CLAUDE.md` for project conventions.

## Standards

- Full type hints on all function signatures and return types
- Async-first: never block the event loop with synchronous I/O
- Graceful degradation: wrap external calls in try/except, return partial results
- Configuration via environment variables, not hardcoded values
- Logging: structured, include context (source name, IDs, etc.)

## Checklist Before Done

- [ ] Linter passes
- [ ] New code has type hints on all signatures
- [ ] External calls have timeout and error handling
- [ ] CLAUDE.md updated if API contract changed
- [ ] Frontend type changes documented (for handoff)
- [ ] No hardcoded secrets or URLs
- [ ] **`.claude/context/backend.md` written** with key files, patterns, changes, and current state
