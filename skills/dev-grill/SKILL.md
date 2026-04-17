---
name: dev-grill
description: >
  Stress-test a plan, feature, or architecture decision by grilling the user from
  every angle. Produces two outputs: (1) documentation that gets committed (decisions,
  architecture, user flows) and (2) a local implementation plan (.claude/plans/).
  Use when: "grill me on this plan", "stress test this design", "challenge my
  assumptions", "what am I missing?", or before committing to a big feature.
---

# Dev Grill — Stress-Test & Document

Interview the user about their plan from every specialist angle. Resolve every branch of the decision tree. Then produce documentation and an implementation plan.

## Phase 1 — Interview

Ask questions **one at a time**. For each question:
1. **Check the codebase first** — use Read, Grep, Glob to find relevant code, then present what you found as context
2. **Provide your recommended answer** based on what you know about the project
3. **Wait for the user's response** before moving on

### Focus areas (adapt to what the user is planning):

**User-Facing Behavior**
- What does the user see? What's the step-by-step workflow?
- What happens on first use vs. returning use?
- What does the loading state look like? The error state? The empty state?
- What feedback does the user get for each action?
- How does this work on mobile?

**Product Scope**
- What does "done" look like? What's explicitly NOT included?
- What's the MVP vs the ideal version?
- Who is this for? What's their motivation?

**Architecture & Data**
- How does data flow through the system?
- What are the API contracts? What shape is the request/response?
- Where does state live? Client, server, or both?
- Does this create new dependencies between modules?
- What gets cached? For how long?

**Edge Cases & Failure**
- What if the external service is down? Slow? Returns garbage?
- What if the input is empty? Huge? Unicode? Malicious?
- What about concurrent users doing the same thing?
- What's the timeout behavior?

**Security & Ops**
- Does user input reach a query, command, or file path?
- How do you know this is working in production?
- What's the rollback plan?

**Testing**
- How would you test this? What's hard to test?
- What would a regression look like?

### When to stop interviewing

Stop when all branches relevant to the plan are resolved, or when the user says they're satisfied.

## Phase 2 — Produce Outputs

After the interview, produce TWO outputs:

### Output A: Documentation (committed to git)

Create or update documentation files in the project. Choose the right format:

| What was grilled | File to write | Location |
|-----------------|---------------|----------|
| Feature design | `docs/features/<feature-name>.md` | Project docs |
| Architecture decision | `docs/adr/<number>-<title>.md` | Project docs |
| User flow / UX | `docs/flows/<flow-name>.md` | Project docs |
| API design | `docs/api/<endpoint-group>.md` | Project docs |

Documentation format:
```markdown
# <Title>

## Context
Why this decision/feature is needed.

## Decisions Made
- Decision 1: [what was decided] — [rationale]
- Decision 2: [what was decided] — [rationale]

## Scope
**In scope:** [what's included]
**Out of scope:** [what's explicitly excluded]

## User Flow (if applicable)
1. User does X
2. System responds with Y
3. ...

## API Contract (if applicable)
[endpoint, request/response shapes]

## Open Questions
- [anything unresolved from the interview]
```

Create the `docs/` directory if it doesn't exist. This documentation is meant to be committed and shared with the team.

### Output B: Implementation Plan (local only)

Write an implementation plan to `.claude/plans/<descriptive-name>.md`. This file stays local (gitignored) and can be used by `/dev-team` or `/dev-team-full` to execute.

Implementation plan format:
```markdown
# Implementation Plan: <Title>

## Steps
1. [specific step — which agent, which files, what to do]
2. [next step]
3. ...

## Files to Create/Modify
- `path/to/file` — what changes

## Acceptance Criteria
1. [testable criterion]
2. [testable criterion]

## Dependencies
- [what must exist before starting]

## Suggested Command
/dev-team-full [task description derived from this plan]
```

## Phase 3 — Handoff

After writing both outputs, tell the user:
1. What documentation was created (paths)
2. What the implementation plan is (path)
3. Suggest the right command to execute: `/dev-team` for simple plans, `/dev-team-full` for complex ones
4. If there are open questions, list them and suggest resolving before implementing

## Tone

Direct and challenging but constructive. Find blind spots, not faults. When you spot an issue, explain WHY it matters and offer a solution.
