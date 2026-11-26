# SKILL — security-code-review

Vulnerability checks, secrets and code review.

## When to use

Before merging any substantial change; before each release (full pass); whenever touching auth, database policies, storage, payments, or external integrations.

## Review checklist

### Authentication & authorization boundaries
- [ ] Every FastAPI endpoint that needs auth actually requires it (no unprotected routes by accident).
- [ ] Identity is derived from the **verified JWT** (signature/issuer/audience/expiry via JWKS) — never from a client-sent user ID.
- [ ] 401 vs 403 semantics correct; no privilege escalation paths (user A acting on user B's resources).
- [ ] Guest (anonymous) users cannot access another user's data — verified, not assumed.

### JWT verification
- [ ] Signature verified against Supabase JWKS with key caching and rotation handling.
- [ ] Issuer, audience, expiration checked; anon-key-signed tokens rejected.
- [ ] Rejection paths unit-tested (forged, expired, wrong issuer/audience, missing).

### RLS & database
- [ ] RLS enabled on every `public` table; policies match `RLS_MATRIX.md`.
- [ ] New/changed policies have allowed-path **and** denied-path tests.
- [ ] Migrations don't weaken policies or grant broad access quietly.

### Secrets
- [ ] No `service_role`, OAuth client secrets, API keys, keystore files in: Dart code, assets, Git history, CI logs, error messages.
- [ ] `.env` git-ignored; `.env.example` current; CI secrets scoped per environment.
- [ ] Supabase redirect allow-lists tight; no wildcard origins.

### API input & logging
- [ ] Pydantic validation on every input; unknown fields rejected where strictness is required (analytics intake).
- [ ] Rate limiting on sensitive endpoints; no user enumeration (uniform error messages/timing).
- [ ] Logs contain no tokens, emails, or sensitive payloads; correlation IDs present.

### Deletion & privacy
- [ ] Account deletion complete (auth user, records, files, third-party tokens incl. Apple revocation).
- [ ] Data collected matches `DATA_INVENTORY.md`; no "just in case" collection.

## Output

Findings go into the PR review + `PROJECT_STATE.md` → Security Findings (severity, status, fix). Critical findings block merge; accepted risks need a dated entry in `SECURITY_OVERVIEW.md`.
