# MY_APPLICATION

Cross-platform mobile application — **Flutter (frontend) + FastAPI (backend) + Supabase (auth & database)**.

> Replace `MY_APPLICATION` with the real app name once the app plan in `reference_material/APP_PLAN/` is provided.

## Stack (fixed)

| Layer | Technology |
| --- | --- |
| Frontend | Flutter + Dart |
| Backend | FastAPI + Python |
| Authentication | Supabase Auth (guest-first, Google, Apple) |
| Database | Supabase PostgreSQL with RLS |
| Access model | Guest first, optional login |
| Monetization | Free, no paid features at launch |
| Distribution | Worldwide (Google Play + Apple App Store) |
| Source control | Git + GitHub |
| CI | GitHub Actions |

Firebase is **not** part of this architecture. See `AGENTS.md` §9.

## Repository layout

```
MY_APPLICATION/
├── AGENTS.md               Universal agent instructions (read first)
├── README.md               This file
├── PROJECT_STATE.md        Current progress — read before any work
├── CHANGELOG.md            Changes over time
├── CONTRIBUTING.md         How to contribute
├── SECURITY.md             Security policy and reporting
├── .env.example            Environment variable template (no real secrets)
│
├── apps/mobile/            Flutter application (lib/, test/, assets/)
├── backend/                FastAPI service (app/, tests/)
├── supabase/               Migrations, seed data, database tests
├── reference_material/     APP_PLAN / REFERENCE_SCREENS / USER_FLOWS /
│                          DESIGN_ASSETS / FEATURE_REQUIREMENTS (design source)
├── docs/                   00_PRODUCT … 10_OPERATIONS + ADR
├── skills/                 Agent skills (SKILL.md per discipline)
├── legal_web/              privacy-policy / terms / account-deletion pages
├── scripts/                Helper scripts
└── .github/workflows/      CI pipelines
```

## Getting started

### Prerequisites

- Flutter SDK (stable channel) + Dart SDK
- Python 3.11+ with `uv` (or pip)
- Git + GitHub account
- Supabase account (separate projects for dev / staging / production)

### Backend

```bash
cd backend
cp ../.env.example .env        # then fill in values — never commit .env
uv sync                        # or: pip install -e ".[dev]"
uv run pytest                  # run tests
uv run uvicorn app.main:app --reload
```

### Mobile

```bash
cd apps/mobile
flutter pub get
flutter analyze
flutter test
```

### Supabase

```bash
supabase login
supabase link --project-ref <ref>
supabase db push              # apply migrations
```

## Key documentation

| File | Purpose |
| --- | --- |
| `PROJECT_STATE.md` | Current progress, known bugs, next tasks |
| `docs/01_ARCHITECTURE/SYSTEM_ARCHITECTURE.md` | How all components communicate |
| `docs/04_DATABASE/DATABASE_SCHEMA.md` | Tables, relationships, constraints |
| `docs/04_DATABASE/RLS_MATRIX.md` | Who can access which data |
| `docs/03_BACKEND/API_ENDPOINT_CATALOG.md` | API endpoints, payloads, responses |
| `docs/05_AUTHENTICATION/AUTH_FLOW.md` | Guest, Google and Apple authentication |
| `docs/07_PRIVACY_COMPLIANCE/DATA_INVENTORY.md` | Data collection and processing |
| `docs/07_PRIVACY_COMPLIANCE/STORE_COMPLIANCE.md` | Apple and Google requirements |
| `docs/08_TESTING/TEST_STRATEGY.md` | Testing approach and coverage |
| `docs/09_DEPLOYMENT/RELEASE_CHECKLIST.md` | Final submission requirements |
| `docs/ADR/` | Architecture Decision Records |

## Contributing

Read `AGENTS.md` first (it applies to humans and agents alike), then `CONTRIBUTING.md`.

## License

To be decided when the app plan is provided.
