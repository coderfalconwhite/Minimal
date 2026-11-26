# SYSTEM_ARCHITECTURE

How all components communicate.

## Component overview

```
┌─────────────────────┐
│  Flutter app        │  apps/mobile
│  Riverpod state     │
│  GoRouter nav       │
│  Dio HTTP           │
└──────┬───────┬──────┘
       │       │
       │ supabase_flutter SDK (auth, RLS-protected reads,
       │ storage where appropriate)
       │       └── HTTPS Bearer <supabase access token>
       ▼            ▼
┌──────────────┐  ┌──────────────────────┐
│ Supabase     │  │ FastAPI backend      │  backend/
│ • Auth       │◄─┤ • /api/v1 endpoints  │
│  (guest,     │  │ • validates JWT via  │
│  Google,     │  │   Supabase JWKS      │
│  Apple)      │  │ • business logic     │
│ • PostgreSQL │  │ • analytics intake   │
│   + RLS      │  │ • service_role ops   │
│ • Storage    │  │   (server only)      │
│ • Observ.    │  └──────────────────────┘
└──────────────┘
```

## Communication rules

1. **Authentication**: Flutter → Supabase Auth directly (anonymous / Google / Apple). FastAPI never authenticates credentials itself; it **verifies Supabase-issued JWTs** (signature via JWKS, issuer, audience, expiry) on every request. ADR-0002.
2. **Data access split**:
   - Simple user-owned reads/writes may go through the Supabase client with RLS enforcement (anon key).
   - Business logic, validation, cross-table operations, analytics intake, and anything privileged go through FastAPI (`service_role` key server-side only). ADR-0005.
3. **No business logic duplication**: a rule lives in exactly one place — Flutter (input UX hints), FastAPI (enforcement), or database (constraints/RLS) — with enforcement always server-side.
4. **Analytics**: Flutter batches events (screen views, scroll milestones 25/50/75/100, feature usage) → FastAPI validates and processes → Supabase PostgreSQL → private admin dashboard. No per-scroll requests.
5. **Environments**: separate Supabase projects and API deployments for development, staging, production. Automated tasks never touch production.

## Responsibility boundaries

| Layer | Owns |
| --- | --- |
| Supabase | Identity, sessions, PostgreSQL + RLS, storage, platform logs/metrics |
| FastAPI | Business logic, API endpoints, server-side validation/authorization, complex DB operations, external integrations, background jobs, analytics processing |
| Flutter | UI/UX, auth screens, on-device session handling, API communication, state, navigation |

## Deployment shape (planned)

- FastAPI: container on a hosting provider (decision pending — see `docs/09_DEPLOYMENT/`).
- Supabase: managed (region chosen after data/latency assessment).
- Flutter: store builds via CI (Part 3).

## Related

- `docs/ADR/` for the decisions behind this architecture
- `docs/04_DATABASE/DATABASE_SCHEMA.md`, `RLS_MATRIX.md`
- `docs/03_BACKEND/API_ENDPOINT_CATALOG.md`
