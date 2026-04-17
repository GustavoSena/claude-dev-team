---
name: dev-team-full
description: >
  Full end-to-end development flow with review cycles. Implements the task, then
  runs code review, UX review, and QA. Classifies the result and, if it doesn't
  meet the bar, routes improvements back to the right agents. Use for important
  features where quality matters more than speed: "build and polish this feature",
  "implement this properly end-to-end", "ship-quality implementation of X".
  Max 3 improvement rounds to avoid infinite loops.
---

# Full Development Flow with Review Cycles

This is the rigorous version of `/dev-team`. It implements the task, reviews the result from multiple angles, and iterates until the output meets the bar or 3 rounds are exhausted.

## Available Agents

| Agent | Isolation | Role in this flow |
|-------|-----------|------------------|
| `backend` | worktree | Implementation |
| `frontend` | worktree | Implementation |
| `ux-design` | none | Post-implementation review |
| `infrastructure` | worktree | Implementation (when needed) |
| `architecture` | none | Pre-implementation design + post-implementation review |
| `qa` | worktree | Post-implementation testing |
| `product` | none | Requirements + acceptance validation |

## Flow

### Phase 1 — Requirements & Design

1. **Product agent**: define acceptance criteria for the task. What does "done" look like? What's out of scope? These criteria are the contract — the review phase checks against them.
2. **Architecture agent** (if structural changes needed): define the technical approach, API contracts, component structure.

Output: numbered acceptance criteria list + technical approach.

### Phase 2 — Implementation

3. **Backend agent** (if backend changes): implement server-side changes.
4. **Frontend agent** (if frontend changes): implement UI changes. Can run in parallel with backend via worktree isolation.
5. **Infrastructure agent** (if infra changes): implement deployment/config changes.

Standard orchestrator conflict resolution applies (see `references/conflict-resolution.md`).

### Phase 3 — Review Round

After implementation, run ALL of these in sequence:

6. **QA agent**: run linter, type checker, tests. Write new tests for the changes. Report pass/fail for each acceptance criterion.
7. **UX agent**: review any UI changes for usability, accessibility, copy quality. Score each finding as critical/high/medium/low.
8. **Architecture agent**: review the implementation against the technical approach. Flag any deviations, missing error handling, or structural issues.

### Phase 4 — Classify

Score the result on this rubric:

| Rating | Criteria | Action |
|--------|----------|--------|
| **Ship** | All acceptance criteria pass. No critical or high UX issues. QA passes. Architecture approved. | Done — report results. |
| **Improve** | Most criteria pass but there are high-severity UX issues, failing tests, or architecture concerns. | Go to Phase 5. |
| **Rethink** | Multiple acceptance criteria fail, or the architecture review flags a fundamental problem. | Present issues to user, ask for direction before re-implementing. |

### Phase 5 — Improvement Round (max 3 rounds)

For each issue found in Phase 3:
1. Route it to the correct agent (UX issues → frontend agent, test failures → backend/frontend agent, architecture issues → implementation agents)
2. Provide the specific finding and what needs to change
3. After fixes, re-run ONLY the reviews that failed (not all of them)

Track the round number. After 3 rounds:
- If still not "Ship" quality, present remaining issues to the user with what was attempted
- Let the user decide: ship as-is, continue manually, or change approach

### Phase 6 — Final Report

Present a structured report:

```
## Result: [Ship / Improve / Rethink]

### What was built
- [summary of changes]

### Acceptance Criteria
- [x] Criterion 1 — PASS
- [x] Criterion 2 — PASS
- [ ] Criterion 3 — FAIL (reason)

### Review Results
- QA: X tests pass, Y tests written, linter clean
- UX: N findings (0 critical, 1 high — addressed in round 2)
- Architecture: approved / concerns noted

### Files Changed
- [list]

### Improvement Rounds
- Round 1: fixed [issues], re-reviewed [areas]
- Round 2: fixed [issues], all reviews pass

### Remaining Issues (if any)
- [issues that weren't resolved within 3 rounds]
```

## Context Maintenance

Same as `/dev-team` — each agent reads/writes its own `.claude/context/<role>.md`. The orchestrator verifies context files are written after each agent returns.

## Relationship to `/dev-team`

`/dev-team` is the fast path — implement and do a basic check. `/dev-team-full` is the thorough path — implement, review from 3 angles, iterate. Use `/dev-team-full` when quality matters more than speed (shipping features, not prototyping).
