# SKILL — supabase-auth-and-security

Guest users, OAuth, JWT, RLS and secure database access.

## When to use

Any work touching authentication, sessions, tokens, database policies, storage access, or the Supabase project configuration.

## Reference documents

`docs/05_AUTHENTICATION/AUTH_FLOW.md` (flows) · `docs/04_DATABASE/RLS_MATRIX.md` (policies) · `docs/ADR/ADR-0002`, `ADR-0003` (decisions).

## Authentication checklist

- [ ] Guest flow: `signInAnonymously()` — persistent session, limitations explained in-app.
- [ ] Google / Apple flows: Supabase native OAuth; Apple uses nonce handling and registered identifiers.
- [ ] Account linking: offered in Settings; conflicts surfaced; never silently overwrite guest data; `profiles.is_anonymous = false` on success.
- [ ] Sessions: persistence, restoration, refresh, sign-out, expired-session handling.
- [ ] Account deletion: full orchestration (records, files, third-party token revocation incl. Apple, auth user removal); guest data reset too.
- [ ] CAPTCHA enabled for anonymous sign-ins; anonymous-account retention policy exists.
- [ ] Dev / staging / prod projects separate; no automated task touches production.

## JWT verification (FastAPI side)

- [ ] Verify **signature** via Supabase JWKS endpoint (`{SUPABASE_URL}/auth/v1/.well-known/jwks.json`), with key caching.
- [ ] Verify **issuer** (`{SUPABASE_URL}/auth/v1`), **audience** (`authenticated`), **expiration**.
- [ ] Identity comes **only** from the verified token — never from a client-sent user ID field.
- [ ] Reject: missing, expired, wrong issuer/audience, bad signature, anon-key-signed tokens. Test each rejection path.
- [ ] 401 (unauthenticated) vs 403 (authenticated but not allowed) used correctly.

## RLS checklist

- [ ] RLS enabled on every `public` table; no policy = inaccessible (safe default).
- [ ] Owner policies via `auth.uid()`; guests covered by the same rules (they have real user rows).
- [ ] Every policy has a test proving **allowed and denied** paths (`supabase/tests/`).
- [ ] Storage buckets use owner-scoped paths (`{user_id}/...`) with per-object policies.
- [ ] `service_role` used only inside FastAPI (server env var); never in Flutter, never in Git.

## Secrets

- [ ] Flutter holds only the anon key + user session tokens.
- [ ] `service_role`, Google/Apple client secrets, API keys: server-only; scan diffs for leaks before commit.
- [ ] `.env.example` updated when env vars change; real `.env` never committed.

## Deliverables per task

Updated `RLS_MATRIX.md` row for new policies · RLS/JWT tests · migration file for schema/policy changes · `PROJECT_STATE.md` security notes.
