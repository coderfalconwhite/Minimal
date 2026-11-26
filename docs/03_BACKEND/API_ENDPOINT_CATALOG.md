# API_ENDPOINT_CATALOG

Versioned API contracts. Every endpoint, its payloads, and responses. Updated through change control (`AGENTS.md` §11) whenever a feature is requested or a contract changes.

Base URL: `/api/v1` · Auth: `Authorization: Bearer <supabase access token>` unless marked *public*.

## Error envelope (all endpoints)

```json
{ "error": { "code": "string", "message": "human-readable", "details": {} } }
```

## Health

| Method & path | Auth | Request | Response (200) | Notes |
| --- | --- | --- | --- | --- |
| `GET /health` | public | — | `{ "status": "ok", "version": "…" }` | Liveness for hosting |

## Authentication-adjacent (Part 1)

| Method & path | Auth | Request | Response | Notes |
| --- | --- | --- | --- | --- |
| `GET /me` | Bearer | — | `{ "id": "uuid", "is_anonymous": bool, "profile": {...} }` | Proves JWT verification; returns caller identity from the verified token |
| `POST /me/profile` | Bearer | profile fields | updated profile | Server-side validation; profile creation/updates |
| `POST /me/delete-account` | Bearer | `{ "confirm": true }` | `202` + status | Orchestrates full deletion: DB records, storage files, third-party tokens; Supabase Auth user removal (server-side). Audit-logged. |

## Analytics intake (Part 1 skeleton, Part 2 events)

| Method & path | Auth | Request | Response | Notes |
| --- | --- | --- | --- | --- |
| `POST /analytics/events` | Bearer | `{ "events": [ { "name": "…", "props": {}, "client_ts": "…" } ] }` (batch, ≤50) | `{ "accepted": n }` | Validates against `ANALYTICS_EVENT_CATALOG.md`; drops unknown events; batch only |

## Application endpoints

| Method & path | Auth | Request | Response | Notes |
| --- | --- | --- | --- | --- |
| — | *Awaiting app plan — endpoints are designed from `reference_material/` analysis, not invented* | | | |

## Contract rules

1. Breaking changes require a new version prefix (`/api/v2`), never in-place mutation.
2. Response schemas live in `app/schemas/` and are covered by contract tests.
3. Rate limits are documented per endpoint once configured.
