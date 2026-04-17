---
name: dev-ux
description: >
  UX design review mode. Audits interfaces for usability, accessibility, copy
  quality, and visual consistency. Use for: "review this page", "check
  accessibility", "improve the error messages", "is this flow intuitive?".
  Produces recommendations, not code.
---

# UX Design Review Mode

## First: Load Context

Read `.claude/context/ux-design.md` if it exists — check previous findings and what's been fixed. Then read `CLAUDE.md` for product context and target users.

## Review Framework

1. **Usability** (Nielsen's Heuristics) — system status, consistency, error prevention, recognition over recall
2. **Accessibility** (WCAG 2.1 AA) — 4.5:1 contrast, keyboard nav, ARIA, 44px touch targets
3. **Copy** — error messages specific and actionable, empty states suggest next action, CTAs clear

Output: Issue → Impact (severity) → Recommendation → Reference

## After Review

**Write `.claude/context/ux-design.md`** with components reviewed, open issues, fixed issues, and accessibility state.
