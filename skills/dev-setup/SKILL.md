---
name: dev-setup
description: >
  Onboard the dev team into a project. Reads docs and code to build initial context,
  asks what you're working on, discovers external tools (Figma, Notion, ticket
  management), and prefills all agent context files. Run this once after installing
  the dev team into a new project: "set up the dev team", "onboard agents",
  "initialize agent context", or "dev setup".
---

# Dev Team Setup — Project Onboarding

Run this once after `install.sh` to build initial context for all agents. This skill reads the project, asks you targeted questions, and writes context files so every subsequent agent invocation starts fast.

## Phase 1 — Read What Exists

Before asking ANY questions, gather everything you can from the project:

### Documentation (check in this order)
1. `CLAUDE.md` — project conventions, tech stack, commands
2. `CONTEXT.md` — product context, architecture, data sources
3. `README.md` — setup instructions, project description
4. `docs/` directory — any existing documentation
5. `CONTRIBUTING.md`, `ARCHITECTURE.md`, `ADR/` — if they exist
6. `.claude/context/*.md` — any existing agent context files

### Code structure (only if docs are insufficient)
1. `package.json`, `pyproject.toml`, `Cargo.toml`, `go.mod` — tech stack and dependencies
2. Entry points — `src/main.*`, `src/App.*`, `src/index.*`, `app/`, `cmd/`
3. Directory listing — `ls -R` at top level to understand the module layout
4. Test setup — test directories, test config files, test commands

### Integrations (check silently)
1. `.mcp.json` — what MCP servers are configured (Figma, Notion, GitHub, etc.)
2. `.github/workflows/` — CI/CD setup
3. `.env.example`, `.envrc` — what environment variables exist (names only, never values)
4. `docker-compose.yml`, `Dockerfile` — containerization

**Important:** do NOT ask about things you can answer from the docs or code. Only ask when the information is genuinely missing.

## Phase 2 — Ask Targeted Questions

Ask the following questions ONE AT A TIME. Skip any that you already answered from Phase 1. For each question, state what you already found and ask for confirmation or correction.

### Required questions (always ask)

**1. Scope of work**
> I found [describe project structure]. Are you working on:
> a) The entire project
> b) Specific sections (which ones?)
> c) A specific feature or task
>
> This determines which agents get context and how deep they go.

**2. Ticket/task management**
> Where do you manage tickets and tasks?
> a) GitHub Issues (I can read these with `gh`)
> b) Linear (need MCP or API access)
> c) Jira (need MCP or API access)
> d) Notion (need MCP access)
> e) Other: ___
> f) None / ad-hoc
>
> This helps the product agent track requirements and the orchestrator reference tickets.

### Conditional questions (ask only if not found in docs/code/config)

**3. Design tools** (skip if Figma MCP found in `.mcp.json`)
> Are there UI designs for this project?
> a) Figma (provide file URL or key — I can use the Figma MCP if configured)
> b) Sketch / Adobe XD / other (provide export location)
> c) Screenshots or mockups (where are they stored?)
> d) No designs — we design as we build

**4. Documentation platform** (skip if docs are comprehensive locally)
> Is there documentation outside the repo?
> a) Notion (need MCP access — I can read and search Notion pages)
> b) Confluence
> c) Google Docs
> d) Everything is in the repo
> e) Other: ___

**5. API documentation** (skip if OpenAPI/Swagger found, or CLAUDE.md covers it)
> Is there API documentation?
> a) OpenAPI/Swagger (provide URL or file path)
> b) Postman collection
> c) Documented in code / CLAUDE.md
> d) Not documented yet

**6. Deployment & environments** (skip if infra docs or CI found)
> How is this deployed?
> a) [Platform] (Vercel, Fly.io, AWS, etc.)
> b) Docker
> c) Manual / SSH
> d) Not deployed yet
> e) I don't work on deployment

**7. Communication preferences** (always ask)
> When agents make decisions, should they:
> a) Ask me before any non-trivial decision
> b) Make reasonable decisions and report what they chose
> c) Only ask when there are genuine trade-offs with no clear winner

### Extensible — add more questions here as needed
<!-- 
To add a new onboarding question:
1. Add it to the conditional section above
2. Specify when to skip it (what to check in docs/code first)
3. Specify which context file(s) the answer should go into
-->

## Phase 3 — Write Context Files

Based on everything gathered, write ALL context files. Use the format from `references/context-template.md`.

### Always write these:

**`.claude/context/backend.md`** — tech stack, entry points, key patterns, API endpoints, dependencies
**`.claude/context/frontend.md`** — framework, component structure, styling approach, state management, types
**`.claude/context/architecture.md`** — system map, module boundaries, data flow, API contracts
**`.claude/context/qa.md`** — test commands, test framework, current coverage state
**`.claude/context/product.md`** — what the product does, who it's for, active scope, ticket management location
**`.claude/context/infrastructure.md`** — deployment target, CI/CD setup, env vars, Docker status
**`.claude/context/ux-design.md`** — design tool info, existing design system/tokens, accessibility state

### Only write if relevant:

If the user is only working on backend, still write frontend/architecture context (they need it for contract awareness) but note "Not actively developing this area — context for reference only."

### What to include in every context file:

```markdown
# [Role] Context
Last updated: [date]
Setup source: /dev-setup onboarding

## Project
[One-line description]

## Key Files
- `path/to/file` — purpose

## Patterns
- How to [do the main thing in this domain]

## External Tools
- Tickets: [where]
- Designs: [where, if applicable]
- Docs: [where, if applicable]

## Scope
[What the developer is working on — entire project or specific sections]

## Current State
[What works, what's in progress]
```

## Phase 4 — Write Project-Level Context

Create or update `.claude/context/project.md` with the cross-cutting information that all agents need:

```markdown
# Project Context
Last updated: [date]

## Overview
[What this project is, who it's for]

## Developer Scope
[What the current developer is working on]

## External Integrations
- Tickets: [system + how to access]
- Designs: [tool + how to access]
- Docs: [platform + how to access]
- Deployment: [target + how to deploy]

## Decision Style
[Ask before deciding / Decide and report / Only ask for trade-offs]

## Conventions
[Key conventions from CLAUDE.md, summarized]
```

## Phase 5 — Report & Recommend

Tell the user:
1. What context files were written (list paths)
2. What external integrations were discovered vs need setup
3. If any MCP servers should be configured (Figma, Notion, Linear) and how
4. Recommend the first command to try:
   - If there's a specific task: suggest `/dev-team <task>` or `/dev-team-full <task>`
   - If the project is new: suggest `/dev-grill` to stress-test the plan
   - If just exploring: suggest `/dev-architecture` for a system review

## Storage Decision

At the end, ask:
> Should the context files stay local (gitignored, default) or should I commit them to the repo so other team members' agents can benefit from this context?
>
> a) Keep local (recommended for solo work — each developer builds their own context)
> b) Commit to git (recommended for teams — shared baseline context)

If the user chooses (b), move the relevant context files to `docs/agent-context/` and commit them. Keep `.claude/context/` as the active copy (gitignored) but populate it from `docs/agent-context/` on future installs.
