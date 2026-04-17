# Conflict Resolution

## Type 1: API Contract Mismatch

**Detection**: Backend response fields don't match frontend TypeScript interfaces.

**Resolution**:
1. Backend is source of truth for field names and types
2. Generate or verify TypeScript types from backend models
3. If a rename is needed: backend renames first, frontend follows

## Type 2: Architecture vs Product Disagreement

**Detection**: Architecture says a feature needs a redesign; Product says ship now.

**Resolution**:
1. Present both positions to the user
2. Default: ship minimal version now, create follow-up for the improvement
3. Document the tech debt explicitly in CLAUDE.md

## Type 3: Overlapping File Changes

**Detection**: Two agents modified the same file (e.g., both touched a config).

**Resolution**:
1. Identify which agent's concern is primary for that file
2. Primary agent's changes take precedence
3. Secondary agent's changes applied on top
4. If line-level conflicts: orchestrator resolves manually

## Type 4: Scope Creep

**Detection**: An agent proposes changes beyond its brief.

**Resolution**:
1. Accept the recommendation as a separate follow-up task
2. Do NOT include it in the current work
3. If the main task depends on the out-of-scope change, escalate to user

## Type 5: Contradictory UX and Product Recommendations

**Detection**: UX says simplify; Product says add more information.

**Resolution**:
1. Default to progressive disclosure: show less initially, reveal more on demand
2. If fundamentally incompatible: present to user with trade-offs
3. User decides, orchestrator enforces
