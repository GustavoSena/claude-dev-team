# Coordination Protocol

## Inter-Agent Communication

Agents cannot communicate directly. The orchestrator mediates all communication by extracting relevant output from one agent and passing it as context to the next.

## Information Flow Patterns

**Sequential handoff (most common):**
```
Product Agent → Requirements document
  ↓
Architecture Agent → Technical specification
  ↓
Backend Agent → Implementation (informed by spec)
  ↓
Frontend Agent → Implementation (informed by spec + backend contract)
  ↓
QA Agent → Test results (validates everything)
```

**Parallel with merge:**
```
Backend Agent → API changes    ─┐
                                 ├→ Orchestrator merges → QA validates
Frontend Agent → UI changes    ─┘
```

**Review cycle:**
```
Implementation Agent → Changes
  ↓
QA Agent → Issues found
  ↓
Orchestrator → Routes issues back to correct agent
  ↓
Implementation Agent → Fixes
  ↓
QA Agent → Re-validates (cap at 3 rounds)
```

## What to Pass Between Agents

| From | To | Pass this | Do NOT pass |
|------|----|-----------|-------------|
| Product | Architecture | Acceptance criteria list | Full prioritization analysis |
| Product | QA | Acceptance criteria (for test derivation) | Product strategy |
| Architecture | Backend | API contract, data model, file list | Full ADR exploration |
| Architecture | Frontend | API contract, component structure | Backend implementation details |
| Backend | Frontend | Actual API response shape (from code) | Internal backend logic |
| Backend | QA | Changed files, new endpoints, edge cases | Implementation narrative |
| Frontend | QA | Changed files, new components, user flows | Styling decisions |
| UX | Frontend | Specific recommendations with example code | General design theory |
| QA | Backend/Frontend | Bug reports with reproduction steps | Test infrastructure details |

## Context Budgeting

Each agent receives only what it needs. Do NOT pass full outputs between agents. Extract and summarize to keep agent context focused and efficient.
