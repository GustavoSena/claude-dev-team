# Claude Dev Team

A portable multi-agent development team for [Claude Code](https://claude.ai/code). Install into any project to get specialized agents for backend, frontend, UX, infrastructure, architecture, QA, and product — with multiple orchestration modes and a one-command onboarding flow.

## Quick Start

```bash
# 1. Install into your project
./install.sh /path/to/your/project

# 2. Start Claude Code in your project, then onboard:
/dev-setup                              # Reads project, asks questions, prefills context

# 3. Use the team:
/dev-team Build a new feature               # Implement + quick verify
/dev-team-full Ship-quality implementation   # Implement → review → iterate
/dev-grill Stress-test my plan              # Challenge every assumption
```

## Commands

### Setup & Planning

| Command | What it does |
|---------|-------------|
| `/dev-setup` | **Project onboarding.** Reads docs and code, asks about your scope, tickets, designs, docs platforms. Prefills all agent context files. Run once after installing. |
| `/dev-grill` | **Stress-test a plan.** Grills you one question at a time from every angle. Produces documentation (committed) and implementation plans (local). |

### Orchestration

| Command | What it does |
|---------|-------------|
| `/dev-team` | **Standard flow.** Analyze → delegate → implement → quick verify (lint, types, build). Fast. |
| `/dev-team-full` | **Thorough flow.** Implement → QA review → UX review → Architecture review → design comparison → classify as Ship/Improve/Rethink → iterate fixes (max 3 rounds). Includes visual design comparison against Figma/mockups when available. |

### Individual Specialists

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
| Just installed, first time | `/dev-setup` |
| Before a big feature | `/dev-grill` |
| Simple single-domain change | `/dev-backend`, `/dev-frontend`, etc. |
| Multi-domain feature (fast) | `/dev-team` |
| Ship-quality feature (thorough) | `/dev-team-full` |
| Bug fix | `/dev-backend` or `/dev-frontend` |

## Onboarding Flow (`/dev-setup`)

When you run `/dev-setup`, it:

1. **Reads everything available** — CLAUDE.md, README, docs/, package.json, .mcp.json, CI config
2. **Asks only what it can't find** — your scope (whole project or specific sections?), ticket management (GitHub Issues, Linear, Jira?), design tools (Figma?), doc platforms (Notion?), deployment, decision style
3. **Prefills all 7+ context files** — so every agent starts with full project awareness
4. **Discovers integrations** — notes which MCP servers are configured and which might need setup

This means the first `/dev-team` invocation after setup is fast — agents already know the codebase.

## Design Comparison (`/dev-team-full`)

When UI changes are involved and design references exist, `/dev-team-full` adds a visual comparison step:

1. Captures a screenshot of the implementation (via Preview MCP, Chrome MCP, or user-provided)
2. Fetches the design reference (Figma MCP, design spec in docs, or provided image)
3. Compares on: layout, typography, colors, states, responsiveness, missing/extra elements
4. Classifies each deviation as **Intentional**, **Bug** (route to frontend), or **Ambiguous** (ask user)

This only runs when designs are available. If none exist, it's skipped with a note.

## How It Works

- **Skills** (`.claude/skills/dev-*/SKILL.md`) — slash commands that set specialist thinking
- **Agents** (`.claude/agents/*.md`) — subagents spawned by orchestrators with restricted tools and worktree isolation
- **Context files** (`.claude/context/<role>.md`) — per-role working memory, read at start, written at end, saves tokens on re-exploration

## Install & Update

```bash
# First install (safe — never overwrites existing files)
./install.sh /path/to/project

# Update templates (replaces agents + skills, preserves context files)
./install.sh --update /path/to/project
```

## Customizing

1. **Edit agent prompts** — replace generic tech references with your stack
2. **Ensure CLAUDE.md is comprehensive** — all agents read it first
3. **Add reference files** — put project-specific patterns in `skills/dev-*/references/`
4. **Add onboarding questions** — edit `skills/dev-setup/SKILL.md` Phase 2, follow the existing pattern

## Prerequisites

- [Claude Code](https://claude.ai/code) CLI
- A project with a `CLAUDE.md` documenting conventions and structure

## Infrastructure

**No special infrastructure needed.** Git worktrees handle parallel agent work on a single machine.

## License

MIT
