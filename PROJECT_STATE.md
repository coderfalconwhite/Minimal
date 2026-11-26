# Project State

> This file must remain concise and factual. Completed work is summarized, not copied repeatedly. Every agent reads this file before starting work and updates it after finishing.

## Current Project Version

0.0.1 — repository scaffold only. No application code implemented yet.

## Current Development Part

**Part 0 — Awaiting app plan.** The repository structure, documentation system, and agent instructions are in place. Part 1 (Foundation) cannot meaningfully start until the app idea, plan, and reference screenshots are supplied in `reference_material/`.

## Completed Features

- Repository structure created (apps/mobile, backend, supabase, reference_material, docs, skills, legal_web, scripts, .github/workflows).
- Universal agent instructions (`AGENTS.md`) with fixed stack, security rules, and workflow.
- Documentation skeleton (`docs/00_PRODUCT` … `docs/10_OPERATIONS`, ADRs 0001–0005).
- Nine agent skills defined under `skills/`.
- CI workflow placeholders (format, analyze, test) under `.github/workflows/`.

## Features In Progress

None. No application feature work has started.

## Pending Features

- Everything application-specific — blocked on `reference_material/APP_PLAN/` and `reference_material/REFERENCE_SCREENS/` being filled by the product owner.
- Part 1 foundation tasks (environment verification, FastAPI skeleton wiring, Supabase project configuration, auth flows, JWT verification, RLS) — ready to start once the app plan arrives.

## Current Architecture

Planned (not yet implemented):

- **Flutter app** — feature-first architecture (`core/` + `features/`), Riverpod (state), GoRouter (navigation), Dio (HTTP), supabase_flutter (auth). Final package versions to be validated and documented before committing.
- **FastAPI backend** — versioned API (`/api/v1`), layered (api / core / authentication / database / models / schemas / repositories / services / middleware / logging).
- **Supabase** — Auth (anonymous + Google + Apple), PostgreSQL with RLS, Storage when required.
- See `docs/01_ARCHITECTURE/SYSTEM_ARCHITECTURE.md` and `docs/ADR/`.

## Backend Status

Skeleton folders and placeholder files only. No endpoints implemented. No Supabase project linked yet.

## Frontend Status

Skeleton folders and placeholder files only. No screens implemented. No pubspec dependencies resolved yet.

## Authentication Status

Not implemented. Policy decided (see `AGENTS.md` §8): guest-first via Supabase anonymous auth, optional Google/Apple, FastAPI verifies Supabase JWT via JWKS. Detailed flow documented in `docs/05_AUTHENTICATION/AUTH_FLOW.md`.

## Database Status

No migrations yet. Deliberate: application-specific entities must not be invented before the app plan is supplied. Only auth/profile scaffolding migrations will be created in Part 1.

## Known Bugs

None — no executable code yet.

## Recent Test Results

None — no test suite executed yet. CI has never run (no commits pushed to GitHub).

## Security Findings

None yet. Baseline rules established in `AGENTS.md` §7 (JWKS verification, no secrets in Flutter, RLS boundary, account deletion, environment separation).

## Important Decisions

- Fixed stack: Flutter/Dart, FastAPI/Python, Supabase Auth + PostgreSQL, Git/GitHub. Recorded in ADR-0001.
- Guest-first access via Supabase Anonymous Authentication with later identity linking. Recorded in ADR-0002.
- FastAPI verifies Supabase access tokens (signature, issuer, audience, expiry) — never trusts client-sent user IDs. Recorded in ADR-0002 / ADR-0003.
- Firebase excluded from the architecture; Supabase-first observability; Sentry preferred for crash monitoring; PostHog optional pending approval. Recorded in AGENTS.md §9.
- Store compliance is an engineering responsibility from Part 1 (account deletion, Sign in with Apple on iOS, data safety declarations).

## Recent Git Changes

- Initial scaffold commit (this repository zip). No GitHub remote configured yet.

## Next Recommended Tasks

1. Product owner fills `reference_material/APP_PLAN/` (idea + plan), `reference_material/REFERENCE_SCREENS/` (screenshots), `USER_FLOWS/`, `FEATURE_REQUIREMENTS/`.
2. Agent analyzes the plan and every screenshot; writes screen inventory, API mapping, database plan, permission matrix, feature backlog into `docs/`.
3. Agent produces `docs/02_FRONTEND/UI_IMPROVEMENT_PROPOSALS.md` and asks the product owner: improved UI/UX or faithful default?
4. After the decision, start Part 1 foundation (environment verification, backend skeleton, Supabase config, auth flows, CI).

## Documentation References

- `AGENTS.md` — universal rules, workflow, security policy
- `docs/01_ARCHITECTURE/SYSTEM_ARCHITECTURE.md`
- `docs/05_AUTHENTICATION/AUTH_FLOW.md`
- `docs/07_PRIVACY_COMPLIANCE/STORE_COMPLIANCE.md`, `DATA_INVENTORY.md`, `PRIVACY_AND_DELETION.md`
- `docs/08_TESTING/TEST_STRATEGY.md`
- `docs/09_DEPLOYMENT/RELEASE_CHECKLIST.md`
- `docs/ADR/ADR-0001` … `ADR-0005`
