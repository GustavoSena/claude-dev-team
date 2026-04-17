# Claude Dev Team

A portable multi-agent development team for [Claude Code](https://claude.ai/code). Install into any project to get specialized agents for backend, frontend, UX, infrastructure, architecture, QA, and product — with three orchestration modes for different situations.

## Quick Start

```bash
# Install into your project
./install.sh /path/to/your/project

# Update after pulling new templates
./install.sh --update /path/to/your/project

# Start Claude Code in your project, then use:
/dev-team Build a new feature               # Implement + quick verify
/dev-team-full Ship-quality implementation   # Implement → review → iterate
/dev-grill Stress-test my plan              # Grill me on every angle
```

## Three Orchestration Modes

### `/dev-team` — Standard (implement + quick verify)

The fast path. Analyzes the task, spawns the right specialist agents, resolves conflicts, runs a quick sanity check (lint, types, build), and reports. Use for most tasks.

### `/dev-team-full` — Thorough (implement → review → iterate)

The rigorous path. After implementation, runs three reviews in sequence:
1. **QA agent** — tests, linting, acceptance criteria pass/fail
2. **UX agent** — usability, accessibility, copy quality scoring
3. **Architecture agent** — structural review against the design

Classifies the result as **Ship** / **Improve** / **Rethink**:
- **Ship**: all criteria pass, no critical issues → done
- **Improve**: issues found → routes fixes to the right agents, re-reviews (max 3 rounds)
- **Rethink**: fundamental problems → presents to user for direction

Use for features that need to be solid before shipping.

### `/dev-grill` — Stress-test a plan

Interviews you one question at a time about your plan, design, or approach. Checks the codebase before asking each question. Covers: product scope, architecture, edge cases, UX, security, testing. Provides a recommended answer for each question.

Use before committing to a big implementation, or when you want to find blind spots.

## Individual Skills

| Command | Role | Writes code? |
|---------|------|-------------|
| `/dev-backend` | Server-side code, APIs, data models | Yes |
| `/dev-frontend` | UI components, state, styling | Yes |
| `/dev-ux` | Usability, accessibility, copy review | No (recommends) |
| `/dev-infra` | Docker, CI/CD, deployment | Yes |
| `/dev-architecture` | System design, API contracts, modules | No (recommends) |
| `/dev-qa` | Tests, linting, edge cases | Yes |
| `/dev-product` | Requirements, acceptance criteria | No (recommends) |

## When to Use What

| Situation | Command |
|-----------|---------|
| Simple single-domain change | `/dev-backend`, `/dev-frontend`, etc. |
| Multi-domain feature (fast) | `/dev-team` |
| Ship-quality feature (thorough) | `/dev-team-full` |
| Before starting a big feature | `/dev-grill` |
| Bug fix | `/dev-backend` or `/dev-frontend` |
| "Is this page usable?" | `/dev-ux` |
| "What should we build?" | `/dev-product` |

## How It Works

- **Skills** (`.claude/skills/dev-*/SKILL.md`) — slash commands that set specialist thinking
- **Agents** (`.claude/agents/*.md`) — subagents spawned by orchestrators with restricted tools and worktree isolation
- **Context files** (`.claude/context/<role>.md`) — per-role working memory, read at start, written at end, saves tokens on re-exploration

## Customizing for Your Project

1. **Edit agent prompts** — replace generic tech references with your stack
2. **Ensure CLAUDE.md is comprehensive** — all agents read it first
3. **Add reference files** — put project-specific patterns in `skills/dev-*/references/`

## Install & Update

```bash
# First install (safe — never overwrites existing files)
./install.sh /path/to/project

# Update templates (replaces agents + skills, preserves context files)
./install.sh --update /path/to/project
```

## Prerequisites

- [Claude Code](https://claude.ai/code) CLI
- A project with a `CLAUDE.md` documenting conventions and structure

## Infrastructure

**No special infrastructure needed.** Git worktrees handle parallel agent work on a single machine.

## License

MIT
