# Claude Dev Team

A portable multi-agent development team for [Claude Code](https://claude.ai/code). Install into any project to get specialized agents for backend, frontend, UX, infrastructure, architecture, QA, and product — plus an orchestrator that coordinates them.

## Quick Start

```bash
# Install into your project
./install.sh /path/to/your/project

# Start Claude Code in your project, then use:
/dev-team Add a new feature end-to-end     # Full team orchestration
/dev-backend Fix the API endpoint           # Backend specialist only
/dev-frontend Update the search UI          # Frontend specialist only
```

## What You Get

### Individual Skills (slash commands)

| Command | Role | Does it write code? |
|---------|------|-------------------|
| `/dev-backend` | Server-side code, APIs, data models | Yes |
| `/dev-frontend` | UI components, state, styling | Yes |
| `/dev-ux` | Usability, accessibility, copy review | No (recommends) |
| `/dev-infra` | Docker, CI/CD, deployment | Yes |
| `/dev-architecture` | System design, API contracts, modules | No (recommends) |
| `/dev-qa` | Tests, linting, edge cases | Yes |
| `/dev-product` | Requirements, acceptance criteria | No (recommends) |

### Team Orchestrator

`/dev-team <task>` — for complex tasks that span multiple areas. The orchestrator:

1. Analyzes the task and decides which agents to involve
2. Spawns advisory agents first (product, architecture, UX)
3. Spawns implementers in parallel worktrees (backend, frontend)
4. Spawns QA to validate
5. Resolves conflicts between agent outputs
6. Synthesizes a coherent result

## When to Use What

| Situation | Command |
|-----------|---------|
| Simple backend change | `/dev-backend` |
| Simple frontend change | `/dev-frontend` |
| Full-stack feature | `/dev-team` |
| Bug fix | `/dev-backend` or `/dev-frontend` (whichever applies) |
| "Should we refactor this?" | `/dev-architecture` |
| "Is this page usable?" | `/dev-ux` |
| "Write tests for this" | `/dev-qa` |
| "What should this feature do?" | `/dev-product` |

## How It Works

Two layers:

- **Skills** (`.claude/skills/dev-*/SKILL.md`) — activated by slash commands, set the specialist mindset for the current session
- **Agents** (`.claude/agents/*.md`) — spawned as subagents by the orchestrator, run in isolated context with restricted tools

The orchestrator (`/dev-team`) uses skills for its own thinking and spawns agents for delegation. Implementer agents (backend, frontend, infra, QA) use git worktree isolation so they can edit files in parallel without conflicts.

## Customizing for Your Project

After installation, customize the agents for your stack:

1. **Edit agent prompts** — replace generic tech references with your specific stack (e.g., "FastAPI" → "Django", "React" → "Vue")
2. **Ensure CLAUDE.md is comprehensive** — all agents read it as their first step. Document your conventions, file structure, and tech stack there.
3. **Add reference files** — put project-specific patterns in `skills/dev-*/references/` subdirectories

## Prerequisites

- [Claude Code](https://claude.ai/code) CLI installed
- A project with a `CLAUDE.md` documenting conventions and structure

## Infrastructure

**No special infrastructure needed.** Git worktrees handle parallel agent file editing on a single machine. No Docker, VMs, or separate environments required.

For the experimental Agent Teams mode (multiple terminal sessions with shared task list), set:
```bash
export CLAUDE_CODE_EXPERIMENTAL_AGENT_TEAMS=1
```

## License

MIT
