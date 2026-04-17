# Context File Template

Each agent writes a `.claude/context/<role>.md` file. Below is the format.
The file should stay under 100 lines. Replace content each time — don't append.

---

## Example: `.claude/context/backend.md`

```markdown
# Backend Context
Last updated: 2026-04-17

## Key Files
- `backend/src/cusco/main.py` — FastAPI app, 9 source singletons, SSE streaming endpoint
- `backend/src/cusco/models.py` — Pydantic models, EntityReport is the main response type
- `backend/src/cusco/sources/base.py` — DataSource ABC with search_by_nif()
- `backend/src/cusco/sources/` — 9 source modules (nif, citius, devedores, contracts, entities, gleif, seg_social, iberinform, adc)

## Patterns
- Each source: singleton in main.py, registered in parallel tasks list, result aggregated via _apply_source_data()
- Bulk data sources (contracts, entities, adc): background loading at startup, cached in /tmp/cusco_cache/
- API sources (gleif, ptdata, seg_social): called per-request with httpx
- Scraping sources (citius, iberinform): session-based with cookies/tokens

## Recent Changes
- Added AdC source: playwright-based scraper, cross-references by company name
- Company name enrichment: entities → gleif → lei fallback chain in _apply_source_data

## Current State
- 9 sources running in parallel, all tested with EDP (500697256)
- Contracts cache: 480K entries, entities: 110K entries
- Known issue: CITIUS returns 302 redirect for some NIFs

## Pending
- Pagination not yet implemented on /api/search response
- AdC scraper only gets first 100 per table (needs pagination)
```

---

## Key Rules

1. Only include files you actually read or modified — not everything in the project
2. Patterns section: how things work, not what they are (the agent needs to know HOW to add/modify)
3. Recent changes: what happened in the last 1-2 sessions
4. Current state: what works, what's broken
5. Pending: known gaps or follow-ups
