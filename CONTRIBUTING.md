# Contributing

Both humans and AI agents contribute to this repository. The rules in `AGENTS.md` apply to everyone.

## Before you start

1. Read `AGENTS.md` completely.
2. Read `PROJECT_STATE.md` to learn where the project stands.
3. Read only the documentation relevant to your task (see the README index).
4. Never assume an undocumented feature is implemented.

## Workflow

1. Create a feature branch from `main`: `feat/<short-name>` or `fix/<short-name>`.
2. Plan substantial changes first: state which files you will touch and why.
3. Implement with production-quality code — no demo-only implementations, no fake API success responses.
4. Run the relevant checks before pushing:
   - Backend: `uv run pytest`, `uv run ruff check .`
   - Mobile: `flutter analyze`, `flutter test`, `dart format --set-exit-if-changed .`
   - Database: `supabase db lint` (and migration review in PR description)
5. Update documentation as part of the same change: affected docs files, `CHANGELOG.md`, and `PROJECT_STATE.md`. New feature? Follow the change-control table in `AGENTS.md` §11.
6. Record important technical decisions as a new ADR in `docs/ADR/`.
7. Open a pull request with: what changed, why, how it was tested (paste actual results), and documentation updated.

## Commit style

Conventional commits: `feat:`, `fix:`, `docs:`, `test:`, `chore:`, `refactor:`.

## What we do not accept

- Placeholder screens or mock data declared as "complete".
- Secrets of any kind in the repository (see `SECURITY.md`).
- Direct modifications of production data or credentials.
- Migrations that were not tested against a fresh database.
- Arbitrary redesigns that ignore `reference_material/`.

## Environment separation

Development, staging, and production Supabase projects are separate. Automated tasks must never touch production data or credentials. See `AGENTS.md` §7.
