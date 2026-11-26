# SKILL — project-documentation

Project state, changelog, ADRs and README maintenance.

## When to use

At the end of every substantial task, and whenever a decision, feature status, or environment fact changes.

## The fixed document set (never renamed, never moved)

| File | Records |
| --- | --- |
| `AGENTS.md` | Universal instructions and development rules |
| `README.md` | Project overview, setup, commands, architecture |
| `PROJECT_STATE.md` | Current progress: completed, pending, broken, known bugs |
| `CHANGELOG.md` | Changes introduced over time |
| `docs/01_ARCHITECTURE/SYSTEM_ARCHITECTURE.md` | How all components communicate |
| `docs/04_DATABASE/DATABASE_SCHEMA.md` | Tables, relationships, constraints |
| `docs/ADR/` | Important technical decisions and their reasoning |
| `docs/04_DATABASE/RLS_MATRIX.md` | Who can access which data |
| `docs/03_BACKEND/API_ENDPOINT_CATALOG.md` | API endpoints, payloads, responses |
| `docs/05_AUTHENTICATION/AUTH_FLOW.md` | Guest, Google and Apple authentication |
| `docs/07_PRIVACY_COMPLIANCE/DATA_INVENTORY.md` | Data collection and processing |
| `docs/07_PRIVACY_COMPLIANCE/STORE_COMPLIANCE.md` | Apple and Google requirements |
| `docs/08_TESTING/TEST_STRATEGY.md` | Testing approach and coverage |
| `docs/09_DEPLOYMENT/RELEASE_CHECKLIST.md` | Final submission requirements |
| `reference_material/` | Original app plan and screen designs (preserved, never rewritten) |

## Rules

1. **PROJECT_STATE.md stays concise and factual** — summarize completed work; do not copy detail into it repeatedly. Follow its fixed section structure (version, part, completed, in progress, pending, architecture, backend/frontend/auth/database status, bugs, test results, security findings, decisions, git changes, next tasks, references).
2. **CHANGELOG.md** gets an entry per merged change (Added/Changed/Fixed/Removed + date).
3. **ADRs are append-only**: a new decision gets the next number (`ADR-000N-slug.md`); superseding an old one marks it "Superseded by ADR-XXXX", never deletes it. Each ADR: context → decision → consequences.
4. **Feature status lifecycle** (`proposed → approved → implemented → tested → released`) is tracked in `FEATURE_BACKLOG.md`; releases mapped in `VERSION_PLAN.md`.
5. A feature request triggers the full change-control update table in `AGENTS.md` §11 — all files in the same change.
6. Never claim a feature is complete in documentation without verification evidence (test output) — documentation lies are worse than gaps.
7. `reference_material/` is read-only for the agent: analysis output goes to `docs/`, never back into the reference folders.

## Definition of done for a documentation task

All affected files updated · statuses consistent everywhere (backlog vs state vs changelog) · no stale "planned" for shipped features · next recommended task actionable.
