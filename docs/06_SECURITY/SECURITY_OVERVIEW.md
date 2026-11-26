# SECURITY_OVERVIEW

Consolidated security posture. Operational rules live in `AGENTS.md` §7 and `SECURITY.md`; this file maps where each control lives and how it is verified.

## Controls

| # | Control | Where implemented | How verified |
| --- | --- | --- | --- |
| 1 | JWT verification (signature/issuer/audience/expiry via Supabase JWKS) | `backend/app/authentication/` | Unit tests with forged/expired/wrong-audience tokens |
| 2 | No client-side trust of user IDs | FastAPI dependencies derive identity from the token only | Code review checklist + tests |
| 3 | Secrets stay server-side (`service_role`, OAuth secrets, API keys) | `.env` (git-ignored), CI secrets | Secret-scanning in CI; review checklist; no such value in `apps/mobile/` |
| 4 | RLS on all user-owned tables & storage | `supabase/migrations/` | RLS tests in `supabase/tests/` (allowed + denied paths) |
| 5 | Environment separation (dev/staging/prod Supabase + API) | Deployment config | Manual audit per release; automated tasks blocked from prod |
| 6 | Account deletion completeness (auth user, records, files, third-party tokens) | FastAPI service + Supabase | Integration test on a disposable project |
| 7 | CAPTCHA on anonymous sign-ins | Supabase project config | Config check in release checklist |
| 8 | Rate limiting on sensitive endpoints | FastAPI middleware | Integration tests |
| 9 | No sensitive data in logs | `backend/app/logging/` | Log-output assertions in tests |
| 10 | Input validation everywhere | Pydantic schemas | Contract tests |
| 11 | Anonymous account retention/cleanup policy | Supabase scheduled job (planned) | Ops runbook check |

## Security review cadence

- Every substantial change: reviewer runs the `security-code-review` skill checklist before merge.
- Before each store submission: full pass, findings recorded in `PROJECT_STATE.md` → Security Findings.

## Known accepted risks

None recorded yet. Anything accepted goes here with a date and reasoning.
