# SKILL — api-integration

Flutter ↔ FastAPI communication and API contracts.

## When to use

Wiring Flutter features to backend endpoints, defining new contracts, or changing existing ones.

## Contract rules (ADR-0005)

1. Every endpoint is documented in `docs/03_BACKEND/API_ENDPOINT_CATALOG.md` **before or with** the code: method, path, auth, request, response, error codes.
2. Versioned under `/api/v1`; breaking changes need a new prefix.
3. One error envelope; the client maps `error.code` → typed failure → user message per screen state.
4. Server-side validation is final (Pydantic); Flutter validates for UX only — never duplicate business rules.
5. Contract tests on the backend pin the schemas; a catalog change without a test change fails review.

## Flutter side

- All FastAPI calls go through the Dio client in `core/networking` — no ad-hoc `http` calls inside features.
- Interceptor attaches the current Supabase access token (`Authorization: Bearer …`); 401 triggers the session-refresh/re-auth path, never a dead end.
- Responses deserialize into typed models (`freezed`/manual); failures into typed errors from `core/errors`.
- Every calling screen implements: loading, error + retry, offline, empty (where applicable).
- Analytics intake is **batched** (≤50 events; scroll milestones 25/50/75/100 only) — never per-interaction requests.

## Adding a feature end-to-end (checklist)

- [ ] Catalog rows written (endpoint + errors)
- [ ] Backend: schema → service → router → tests
- [ ] Flutter: model → repository → provider → screen wiring → states → widget test
- [ ] `SCREEN_ACTION_BACKEND_MAP.md` updated (action → endpoint)
- [ ] Feature backlog status advanced; `CHANGELOG.md` + `PROJECT_STATE.md` updated

## Anti-patterns

Fake success responses ("TODO: call API later") · user IDs sent in payloads for identity · hardcoded URLs (use `core/config`) · business rules duplicated in Flutter.
