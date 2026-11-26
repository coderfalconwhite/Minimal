# SKILL — fastapi-backend-engineering

API development, service structure and validation.

## When to use

Any work in `backend/` — endpoints, services, schemas, middleware, jobs.

## Structure (fixed)

`app/api/v1` (routers) · `app/core` (config, security, exceptions) · `app/authentication` (JWT verification) · `app/database` (engine/session, service client) · `app/models` · `app/schemas` · `app/repositories` (data access) · `app/services` (business logic) · `app/middleware` · `app/logging` · `main.py`.

Layering: router → service → repository. Routers never touch the DB directly; services hold business rules; repositories hold queries.

## Rules

- **Versioned API**: everything under `/api/v1`; breaking change = new version prefix.
- **JWT on every protected endpoint** via the dependency in `app/authentication` (verify signature/issuer/audience/expiry against Supabase JWKS; identity from token only). See the supabase-auth-and-security skill.
- **Validate everything**: Pydantic schemas for every request/response; reject unknown fields on intake endpoints (analytics).
- **One error envelope**: `{ "error": { "code", "message", "details" } }`; raise typed exceptions from `core/exceptions`; never leak stack traces.
- **Config via env** (`core/config.py`, pydantic-settings); `.env.example` updated in the same PR; fail fast on missing required vars at startup.
- **Rate limiting** on sensitive endpoints (config-driven); **structured logging** with correlation IDs; no tokens, emails, or sensitive payloads in logs.
- **service_role key server-side only**; privileged operations run in services, never exposed via an endpoint.
- **Background jobs / scheduled work** (e.g. analytics rollups, retention cleanup) documented in `docs/10_OPERATIONS/OPERATIONS.md` when added.

## Tests

- Unit: services with faked repositories.
- Integration: routers against a test database/app (httpx); auth paths covered with real/forged tokens.
- Contract: response schemas match `docs/03_BACKEND/API_ENDPOINT_CATALOG.md`.
- Never run tests against the production Supabase project.

## Definition of done

`pytest` green · catalog updated · `.env.example` updated if vars changed · `PROJECT_STATE.md` + `CHANGELOG.md` updated · no secrets in diffs.
