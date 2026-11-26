# Backend Architecture (FastAPI)

## Structure

```
backend/
├── app/
│   ├── api/
│   │   └── v1/           versioned routers
│   ├── core/             config.py, security.py, exceptions.py
│   ├── authentication/   Supabase JWT verification (JWKS), dependencies
│   ├── database/         engine/session, Supabase service client
│   ├── models/           ORM models
│   ├── schemas/          Pydantic request/response schemas
│   ├── repositories/     data access
│   ├── services/         business logic
│   ├── middleware/       rate limiting, request logging
│   ├── logging/          structured logging setup
│   └── main.py           app factory
├── tests/                unit + integration + contract tests
├── pyproject.toml
├── uv.lock
└── README.md
```

## Non-negotiables

1. **Versioned API** — everything under `/api/v1`.
2. **JWT verification on every protected endpoint** — Supabase JWKS; check signature, issuer, audience, expiration. Never trust client-sent user IDs. (ADR-0002)
3. **Consistent error responses** — one error envelope across the API; no stack traces to clients.
4. **Input validation** — Pydantic schemas for every request body and query.
5. **Request logging** — structured, correlation IDs, no sensitive data (tokens, emails) in logs.
6. **Rate limiting** where appropriate (config-driven).
7. **Privileged credentials stay here** — `service_role` key, OAuth client secrets are server-only env vars, never shipped to Flutter.
8. **Automated tests** — unit (services), integration (routers + test DB), contract (schema stability, recorded in `API_ENDPOINT_CATALOG.md`).

## Analytics intake (planned)

`POST /api/v1/analytics/events` — batched events from Flutter, validated, privacy-classified, stored to Supabase PostgreSQL. Milestone-based (scroll 25/50/75/100), never per-frame. Foreground-time distinction. See `docs/10_OPERATIONS/ANALYTICS_EVENT_CATALOG.md`.

## Environments

`APP_ENV=development|staging|production` with matching Supabase projects; staging hosts release candidates; production is never modified by automated tasks.
