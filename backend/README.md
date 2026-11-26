# Backend (FastAPI)

Business logic, versioned API (`/api/v1`), Supabase JWT verification, analytics intake. Architecture: `docs/03_BACKEND/BACKEND_ARCHITECTURE.md` · contracts: `API_ENDPOINT_CATALOG.md` · rules: `skills/fastapi-backend-engineering/SKILL.md`.

## Structure

```
app/
├── api/v1/          versioned routers
├── core/            config.py, exceptions.py (+ security.py in Part 1)
├── authentication/  Supabase JWT verification (JWKS) dependencies
├── database/        engine/session + server-side service client (Part 1)
├── models/ schemas/ repositories/ services/   (with features, per plan)
├── middleware/      request-ID, logging, rate limiting (Part 1)
├── logging/         structured logging (Part 1)
└── main.py          app factory + error envelope
tests/
```

## Setup

```bash
cp ../.env.example .env    # fill values — never commit .env
uv sync                    # or: pip install -e ".[dev]"
uv run uvicorn app.main:app --reload
uv run pytest
uv run ruff check .
```

## Status

Scaffold with runnable foundation: app factory, config, error envelope, `/api/v1/health`, fail-closed JWT dependency stub, smoke tests. JWKS verification, database, middleware land in Part 1 (see `app/core/LAYERS.md` TODOs and `docs/08_TESTING/TEST_STRATEGY.md`).

## Security invariants

- Identity comes only from verified Supabase JWTs — never client-sent user IDs.
- `service_role` key and OAuth secrets live here (env vars), never in Flutter.
- One error envelope; no stack traces to clients.
