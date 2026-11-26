# Changelog

All notable changes to this project are documented in this file.
Format based on [Keep a Changelog](https://keepachangelog.com/en/1.1.0/); versioning follows [Semantic Versioning](https://semver.org/).

## [Unreleased]

### Added — 2026-11-26

- Initial repository scaffold: `apps/mobile` (Flutter), `backend` (FastAPI), `supabase` (migrations/seed/tests), `reference_material/`, `docs/` (00–10 + ADR), `skills/` (9 skills), `legal_web/`, `scripts/`, `.github/workflows/`.
- `AGENTS.md` — universal agent instructions: fixed stack, information-loading rules, workflow, security rules, authentication policy, backend & monitoring policy, development parts, change control.
- `README.md` — project overview, setup commands, documentation index.
- `PROJECT_STATE.md` — current status (scaffold only, awaiting app plan).
- `CHANGELOG.md`, `CONTRIBUTING.md`, `SECURITY.md`, `.gitignore`, `.env.example`.
- Documentation skeleton with the fixed document set: SYSTEM_ARCHITECTURE, DATABASE_SCHEMA, RLS_MATRIX, API_ENDPOINT_CATALOG, AUTH_FLOW, DATA_INVENTORY, STORE_COMPLIANCE, PRIVACY_AND_DELETION, TEST_STRATEGY, RELEASE_CHECKLIST, FEATURE_BACKLOG, VERSION_PLAN, SCREEN_ACTION_BACKEND_MAP, DEVICE_CAPABILITY_MATRIX, ANALYTICS_EVENT_CATALOG.
- ADRs 0001–0005 (architecture, authentication strategy, database security, state management, API communication).
- CI workflow placeholders: flutter-checks.yml, backend-checks.yml, supabase-checks.yml.

### Notes

- No application code yet. App-specific features, schema, and endpoints wait for the app plan and reference screens in `reference_material/`.
- Initial repository scaffold published to `https://github.com/coderfalconwhite/Minimal` on `main` (2026-11-27).
