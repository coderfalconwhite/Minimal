# FEATURE_BACKLOG

Every feature in the project, with lifecycle status. The agent updates this file whenever a feature is requested, approved, implemented, tested, or released (change control — `AGENTS.md` §11).

Statuses: `proposed → approved → implemented → tested → released` (+ `rejected`, `deferred`).

## Foundation features (stack-level, already decided)

| ID | Feature | Status | Notes |
| --- | --- | --- | --- |
| F-001 | Guest (anonymous) authentication | approved | Supabase anonymous sign-in; persistent session; documented limitations |
| F-002 | Google sign-in | approved | Supabase native OAuth flow |
| F-003 | Apple sign-in | approved | Required on iOS alongside Google (Apple Guideline 4.8); nonce handling |
| F-004 | Guest → account linking | approved | Settings entry; conflict handling; no silent data overwrite |
| F-005 | User profile creation | approved | On first session (guest or registered) |
| F-006 | Session persistence & restoration | approved | Secure local session handling |
| F-007 | Sign-out | approved | |
| F-008 | Authentication error & expired-session handling | approved | |
| F-009 | Account deletion (in-app + web) | approved | Auth user, profile, records, files, third-party tokens; store requirement |
| F-010 | Guest data reset/deletion | approved | |
| F-011 | FastAPI JWT verification (JWKS) | approved | Signature, issuer, audience, expiry |
| F-012 | RLS on all user-owned tables | approved | Matrix in `docs/04_DATABASE/RLS_MATRIX.md` |
| F-013 | Analytics event pipeline | approved | Flutter → FastAPI → Supabase; batched; milestone-based; privacy-classified |
| F-014 | Crash/error monitoring | proposed | Sentry preferred candidate; privacy review first |
| F-015 | Private admin analytics dashboard | proposed | Built on Supabase aggregates; after app plan arrives |

## Application features

| ID | Feature | Status | Notes |
| --- | --- | --- | --- |
| — | *Awaiting app plan in `reference_material/APP_PLAN/`* | — | Do not invent features before the plan arrives |

## Change log

| Date | Change |
| --- | --- |
| 2026-11-26 | Backlog created with foundation features from the architecture decision |
