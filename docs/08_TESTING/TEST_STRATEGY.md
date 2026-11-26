# TEST_STRATEGY

Testing approach and coverage. Two parts, run continuously from Part 1 onward.

## Part 1 — Foundation tests (start immediately)

| Area | What runs | Where |
| --- | --- | --- |
| Git & environment | Verify toolchain (Flutter, Dart, Python, Supabase CLI) versions | `scripts/verify_env.sh` + CI |
| Flutter formatting & static analysis | `dart format --set-exit-if-changed`, `flutter analyze` | CI `flutter-checks.yml` |
| FastAPI endpoints & unit tests | `pytest` (unit + integration) | CI `backend-checks.yml` |
| Supabase migration checks | Migrations apply cleanly to a fresh database | CI `supabase-checks.yml` |
| Auth & JWT verification | Forged / expired / wrong-issuer / wrong-audience / missing tokens rejected; valid token accepted | backend tests |
| RLS & authorization | Owner allowed, non-owner denied, anon denied, service_role paths | `supabase/tests/` |
| GitHub Actions | All workflows green on every PR | CI |

## Part 2 — Application tests (continuous)

| Area | What runs |
| --- | --- |
| Flutter widget tests | Every meaningful widget & state (empty/loading/error/success/disabled/offline) |
| Screen & navigation tests | GoRouter routes, guards, deep links |
| API integration tests | Real request/response against a test backend; error mapping |
| Login & session handling | Guest, Google, Apple, linking, sign-out, restoration, expiry |
| Responsive layout checks | Phone dimensions; text scaling; adaptive navigation |
| Error, loading & offline states | Every screen's six states |
| Regression tests | Existing features re-tested on every change that touches them |

## Rules

1. **Test every meaningful change** — a PR without tests for changed behavior is not done.
2. Never report a feature as complete without verification results pasted into the report.
3. Backend tests never hit the production Supabase project; they use a local/disposable project or container.
4. RLS tests must cover both the allowed and the denied path.
5. Contract tests keep `API_ENDPOINT_CATALOG.md` honest — a catalog change without a schema/test change fails review.
6. UI reference comparisons: implemented screens are compared against `reference_material/REFERENCE_SCREENS/` during review.

## Current status

No test suites exist yet — the repo is scaffold-only (see `PROJECT_STATE.md`). CI workflows are defined and will enforce the Part 1 list once code lands.
