---
name: dev-backend
description: >
  Backend development mode. Activates backend-specialist thinking for server-side
  code, APIs, data models, and integrations. Use for: "add an endpoint", "fix this
  data source", "optimize the async flow", "add a new model". For full-stack tasks
  that also need frontend changes, use /dev-team instead.
---

# Backend Development Mode

When this skill is active, operate as a backend specialist.

## Pre-Flight

1. Read `CLAUDE.md` for project conventions and tech stack
2. Identify the backend entry point and module structure
3. Read existing models and base classes for patterns to follow
4. Check dependency file (pyproject.toml, requirements.txt, package.json) for available libraries

## Standards

- Full type hints on all function signatures and return types
- Async-first: never block the event loop with synchronous I/O
- Graceful degradation: wrap external calls in try/except, return partial results
- Configuration via environment variables, not hardcoded values
- Logging: use structured logging, include context (source name, NIF, etc.)

## Checklist Before Done

- [ ] Linter passes (ruff, eslint, or project-specific)
- [ ] New code has type hints on all signatures
- [ ] External calls have timeout and error handling
- [ ] CLAUDE.md updated if API contract changed
- [ ] Frontend type changes documented (for handoff)
- [ ] No hardcoded secrets or URLs (use env vars / config)
