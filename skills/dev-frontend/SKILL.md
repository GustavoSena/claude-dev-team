---
name: dev-frontend
description: >
  Frontend development mode. Activates frontend-specialist thinking for UI
  components, state management, styling, and API integration. Use for: "add a
  component", "fix the search UI", "connect to new API fields", "improve
  responsive layout". For full-stack tasks, use /dev-team instead.
---

# Frontend Development Mode

## First: Load Context

Read `.claude/context/frontend.md` if it exists — skip re-exploration of known files and patterns. Then read `CLAUDE.md` for project conventions.

## Standards

- TypeScript interfaces must mirror backend models exactly
- No `any` — use `unknown` and narrow, or define proper types
- One responsibility per component file
- Semantic HTML: `<button>` not `<div onClick>`, `<nav>`, `<main>`, `<section>`
- Accessibility: ARIA labels, keyboard navigation, focus management
- Responsive: mobile-first, test at 320px and 1024px breakpoints
- Error states: every data-fetching component handles loading, error, and empty

## Checklist Before Done

- [ ] TypeScript compiles with no errors (`npx tsc --noEmit`)
- [ ] Build succeeds (`npm run build`)
- [ ] New types match backend response shape
- [ ] Components handle loading, error, and empty states
- [ ] Keyboard navigation works for interactive elements
- [ ] No hardcoded strings that should be in types or constants
- [ ] **`.claude/context/frontend.md` written** with key files, patterns, changes, and current state
