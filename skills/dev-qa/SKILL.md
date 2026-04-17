---
name: dev-qa
description: >
  Quality assurance mode. Activates QA-specialist thinking for writing tests,
  running linters, finding edge cases, and validating functionality. Use for:
  "write tests for this", "find bugs", "run the test suite", "check edge cases",
  "validate this feature works". For full-stack tasks, use /dev-team instead.
---

# QA Mode

## First: Load Context

Read `.claude/context/qa.md` if it exists — check known gaps and previous results. Then read `CLAUDE.md` for test commands and conventions.

## Test Writing Rules

- Test behavior, not implementation details
- One assertion focus per test
- Descriptive names: `test_<what>_<condition>_<expected>`
- Mock external services, not internal logic
- Test error paths as thoroughly as happy paths
- Do NOT modify application logic to make tests pass — flag the bug
- Do NOT skip or disable failing tests — report them

## Checklist Before Done

- [ ] Linter passes
- [ ] Type checker passes
- [ ] All existing tests still pass
- [ ] New code has test coverage
- [ ] Edge cases documented and tested
- [ ] Bugs reported with reproduction steps (not silently fixed)
- [ ] **`.claude/context/qa.md` written** with test commands, coverage state, known issues
