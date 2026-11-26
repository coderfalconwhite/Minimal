# ADR-0003: Database Security

- **Status**: Accepted
- **Date**: 2026-11-26

## Context

Supabase PostgreSQL holds all application data. Two access paths exist: the Flutter client (anon key + user session) and the FastAPI service (service_role). Data is user-owned; guests and registered users must be equally isolated.

## Decision

1. **RLS on every table in `public`** — a table without a policy is inaccessible to clients; that is the safe default, not an oversight. Owner checks use `auth.uid()`; anonymous guests have real user rows, so one policy set covers both user kinds.
2. **Client access is owner-scoped only.** Simple user-owned reads/writes may go through the supabase Flutter client under RLS. Anything privileged — cross-user operations, aggregation, deletion orchestration, analytics intake — runs through FastAPI with the server-only `service_role` key.
3. **`service_role` never leaves the server.** It is a server-side environment variable; the Flutter app holds only the anon key and session tokens.
4. **Version-controlled, forward-only migrations** in `supabase/migrations/`, tested against a fresh database; every policy change ships with an RLS test proving both allowed and denied paths (`docs/04_DATABASE/RLS_MATRIX.md`).
5. **Environment separation**: distinct Supabase projects for development, staging, production; automated tasks never touch production.

## Consequences

- Two independent security boundaries: RLS (database) and FastAPI authorization (service) — a bug in one does not expose data if the other holds.
- Policy complexity stays low: mostly `id = auth.uid()` owner rules plus service-role bypass.
- Migration discipline is mandatory; editing an applied migration on a shared environment is forbidden.
- Storage follows the same model: owner-scoped paths (`{user_id}/...`) with per-object policies.
