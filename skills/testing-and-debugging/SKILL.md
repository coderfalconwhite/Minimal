# SKILL — testing-and-debugging

Automated tests, debugging and regression prevention.

## When to use

Writing/running any test, investigating a bug, or verifying a change didn't break existing behavior.

## Test map (docs/08_TESTING/TEST_STRATEGY.md is authoritative)

| Suite | Location | Run with |
| --- | --- | --- |
| Flutter unit/widget | `apps/mobile/test/` | `flutter test` |
| Flutter analysis | — | `flutter analyze`, `dart format --set-exit-if-changed .` |
| Backend unit/integration/contract | `backend/tests/` | `uv run pytest` |
| RLS policies | `supabase/tests/` | per `supabase/README.md` |
| Migrations | fresh DB apply | CI `supabase-checks.yml` |
| All | CI | `.github/workflows/*` on every PR |

## What must be tested

- **Part 1 foundation**: JWT verification (valid, expired, wrong issuer/audience, bad signature, missing), auth flows, RLS allowed+denied paths, migrations on a fresh DB, health endpoint.
- **Part 2 application**: widget tests per screen (render, actions, error/empty/loading/offline), navigation & guards, API integration with error mapping, login/session handling, responsive layouts & text scaling, regression tests for existing features.

## Rules

1. Test every meaningful change — new behavior without a test is incomplete.
2. Regression discipline: before fixing a bug, write the failing test that reproduces it; fix; keep the test forever.
3. Never report "works" without pasted command output in the task report.
4. Tests never touch production data or credentials; backend tests use disposable projects/containers.
5. Flaky tests are treated as bugs — quarantine with a ticket, fix, do not delete silently.

## Debugging protocol

1. Reproduce reliably (exact steps, environment, account type: guest/Google/Apple).
2. Locate the layer: Flutter UI / state / networking / FastAPI / database / Supabase config.
3. Find the **root cause** — a fix at symptom level is rejected in review.
4. Fix + failing-test-now-passing + regression sweep of touched features.
5. Record the bug, cause, and fix in `PROJECT_STATE.md` → Known Bugs (resolved) and `CHANGELOG.md`.
