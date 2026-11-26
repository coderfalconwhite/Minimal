# OPERATIONS

Runbooks, monitoring, and maintenance procedures.

## Environments

| Environment | Supabase | API | Users |
| --- | --- | --- | --- |
| Development | dev project | local / dev deploy | developers, test users |
| Staging | staging project | staging deploy | release candidates |
| Production | prod project | prod deploy | real users |

Automated tasks never touch production data or credentials.

## Monitoring stack (decided / pending)

| Concern | Tool | Status |
| --- | --- | --- |
| Auth / DB / API / Storage logs & metrics | Supabase Observability (built-in logs, ~200 Postgres metrics, reports) | decided — primary |
| Application analytics | Own pipeline: Flutter events → FastAPI → Supabase → private admin dashboard | decided |
| Crash & error monitoring | Sentry (Flutter + Android/iOS native + FastAPI) | recommended candidate — privacy review before adoption |
| Product analytics platform | PostHog | optional — requires owner approval before integration |

Operational logs and product analytics are maintained separately (`AGENTS.md` §9).

## Routine procedures

- **Migrations**: forward-only, `supabase/migrations/NNNN_description.sql`, tested against a fresh DB before merge; never edited after being applied to a shared environment.
- **Backups**: Supabase-managed PITR (verify per plan tier before production launch).
- **Anonymous-account cleanup**: scheduled job per `PRIVACY_AND_DELETION.md` retention (Supabase does not clean up anonymous accounts automatically).
- **Secret rotation**: quarterly, or immediately on any exposure; CI secrets included.
- **Incidents**: record in `PROJECT_STATE.md` → Known Bugs; security incidents follow `SECURITY.md`.

## Pending decisions (owner)

Backend hosting provider · Supabase deployment region (after data & latency assessment) · monitoring provider final choice (after SDK privacy review).
