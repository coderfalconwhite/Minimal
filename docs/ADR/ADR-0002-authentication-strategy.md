# ADR-0002: Authentication Strategy

- **Status**: Accepted
- **Date**: 2026-11-26

## Context

The product requires guest access without mandatory registration, with optional Google and Apple login, worldwide distribution, and both stores' policies to satisfy (Apple Guideline 4.8 requires Sign in with Apple when third-party login is offered; both stores require in-app account deletion).

## Decision

1. **Guest-first via Supabase Anonymous Authentication.** `signInAnonymously()` creates a real authenticated identity with RLS-covered data. Registration is never required to use basic features.
2. **Optional OAuth** via Supabase's supported native Google and Apple flows (Apple with nonce handling). Sign in with Apple ships on iOS.
3. **Identity linking, not replacement.** Guests can attach Google/Apple to their existing anonymous identity later in Settings (Supabase manual linking mode). Existing-account conflicts are surfaced to the user; guest data is never silently transferred or overwritten.
4. **FastAPI never authenticates credentials.** It verifies Supabase-issued JWTs — signature via the Supabase JWKS endpoint, plus issuer, audience, and expiration — and derives the user identity from the verified token. Client-sent user IDs are never trusted.
5. **Deletion is a first-class flow**: Supabase Auth user, app records, storage files, third-party token revocation (Apple), with an external web deletion page for Google Play.
6. **Abuse protection**: CAPTCHA on anonymous sign-ins; an explicit retention/cleanup policy for anonymous accounts (Supabase does not remove them automatically).

## Consequences

- One identity model covers guests and registered users (both are `auth.users` rows) — RLS policies stay uniform.
- Guest sessions are persistent but not recoverable across sign-out/data-clear/device change; the app must explain this and offer linking.
- Anonymous accounts accumulate without a cleanup job — an operational responsibility from day one.
- Full auth flow documented in `docs/05_AUTHENTICATION/AUTH_FLOW.md`.
