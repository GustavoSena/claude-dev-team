---
name: dev-infra
description: >
  Infrastructure and DevOps mode. Activates infra-specialist thinking for Docker,
  CI/CD, deployment, environment config, and monitoring. Use for: "dockerize this",
  "add CI pipeline", "set up deployment", "fix the dev script". For tasks that also
  need app code changes, use /dev-team instead.
---

# Infrastructure Mode

## First: Load Context

Read `.claude/context/infrastructure.md` if it exists — skip re-inventorying known files. Then read `CLAUDE.md` for existing infra setup.

## Standards

- Never hardcode secrets — environment variables only
- Docker: multi-stage builds, minimal final image, non-root user
- CI: fail fast (lint → type check → test → build), cache dependencies
- Health checks: every deployable service needs one
- Documentation: every new env var gets a comment explaining its purpose

## Checklist Before Done

- [ ] No secrets in committed files
- [ ] New env vars documented (name + description, never values)
- [ ] Docker build succeeds (if applicable)
- [ ] CI pipeline passes (if applicable)
- [ ] Rollback procedure documented for risky changes
- [ ] .gitignore updated for new generated/secret files
- [ ] **`.claude/context/infrastructure.md` written** with infra files, env vars, deployment state
