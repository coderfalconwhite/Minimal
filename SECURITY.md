# Security Policy

## Supported versions

| Version | Supported |
| --- | --- |
| main (development) | yes |

## Core security rules (enforced by AGENTS.md)

1. **JWT verification** — FastAPI verifies every Supabase access token's signature, issuer, audience, and expiration via the Supabase JWKS endpoint. User IDs sent by clients are never trusted.
2. **No secrets in the client** — Supabase `service_role` key, Apple client secret, Google client secret, and any AI/API keys stay on the server. The Flutter app only ever holds the anon key and user session tokens.
3. **RLS everywhere** — Row Level Security protects all user-owned tables and storage buckets. See `docs/04_DATABASE/RLS_MATRIX.md`.
4. **Environment separation** — separate Supabase projects and API deployments for development, staging, and production. Automated tasks never modify production data or credentials.
5. **Account deletion** — full deletion across Supabase Auth, profiles, database records, uploaded files, and third-party services; Apple token revocation where Sign in with Apple was used.
6. **Guest safety** — anonymous sessions are persistent but not recoverable; identity linking never silently overwrites data belonging to another account.

## Reporting a vulnerability

Do not open a public issue for security problems. Contact the maintainer privately with:

- a description of the issue and its impact,
- steps or proof of concept,
- affected component (Flutter / FastAPI / Supabase / CI).

We aim to respond within 7 days. Please avoid automated scanning that degrades service availability.

## Secrets handling

- `.env` files are git-ignored; use `.env.example` as the template.
- Rotate any secret that was committed, exposed in logs, or shipped in a client build — treat exposure as a compromise.
- CI secrets live in GitHub encrypted secrets, scoped per environment.

## Security review

Before each release, run the `security-code-review` skill checklist (`skills/security-code-review/SKILL.md`) and record findings in `PROJECT_STATE.md` → Security Findings.
