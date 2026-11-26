# ADR-0005: API Communication

- **Status**: Accepted
- **Date**: 2026-11-26

## Context

Flutter talks to two backends: Supabase (auth, owner-scoped data) and FastAPI (business logic). Contracts must be stable, versioned, testable, and documented — and the client must never be trusted with identity or privileges.

## Decision

1. **Versioned REST**: all FastAPI endpoints live under `/api/v1`. Breaking changes require `/api/v2`; in-place mutation is forbidden.
2. **Bearer auth everywhere**: Dio attaches the Supabase access token; FastAPI verifies it via JWKS (ADR-0002) and derives identity server-side.
3. **Documented contracts**: every endpoint is recorded in `docs/03_BACKEND/API_ENDPOINT_CATALOG.md` (method, path, auth, request, response) and covered by contract tests; the catalog and schemas move in the same PR.
4. **One error envelope** across the API: `{ "error": { "code", "message", "details" } }` — no stack traces to clients. The client maps `code` to typed failures and user-friendly messages per screen state (empty/loading/error/success/disabled/offline).
5. **Validation is server-side and final**: Flutter does UX-level hints, but FastAPI's Pydantic schemas are the enforcement point; business logic is never duplicated in Flutter and the database (one home per rule, enforcement always server-side).
6. **Access-path split**: simple owner-scoped data may use the Supabase client directly (RLS-enforced); business operations go through FastAPI (`service_role` server-side).

## Consequences

- Contract tests catch accidental breaking changes before release.
- Screens handle API failures uniformly through the shared error mapping.
- Analytics payloads are validated against the event catalog at the API boundary (unknown events dropped, never stored).
- Adding an endpoint always updates three artifacts together: code, catalog, tests — enforced by change control (`AGENTS.md` §11).
