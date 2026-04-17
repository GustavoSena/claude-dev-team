---
name: dev-infra
description: >
  Infrastructure and DevOps mode. Activates infra-specialist thinking for Docker,
  CI/CD, deployment, environment config, and monitoring. Use for: "dockerize this",
  "add CI pipeline", "set up deployment", "fix the dev script". For tasks that also
  need app code changes, use /dev-team instead.
---

# Infrastructure Mode

When this skill is active, operate as an infrastructure specialist.

## Pre-Flight

1. Read `.claude/context/infrastructure.md` if it exists — skip re-inventorying known files
2. Read `CLAUDE.md` for existing infra setup
3. Check for: Dockerfile, docker-compose.yml, .github/workflows/, .envrc, dev.sh
4. Identify the deployment target if documented
5. Check .gitignore for secrets/config patterns

## Standards

- Never hardcode secrets — environment variables only
- Docker: multi-stage builds, minimal final image, non-root user
- CI: fail fast (lint → type check → test → build), cache dependencies
- Health checks: every deployable service needs one
- Documentation: every new env var gets a comment explaining its purpose

## Checklist Before Done

- [ ] No secrets in committed files (check .env, .envrc, config files)
- [ ] New env vars documented (name + description, never values)
- [ ] Docker build succeeds (if applicable)
- [ ] CI pipeline passes (if applicable)
- [ ] Rollback procedure documented for risky changes
- [ ] .gitignore updated for any new generated/secret files
- [ ] `.claude/context/infrastructure.md` updated with what you learned and changed
