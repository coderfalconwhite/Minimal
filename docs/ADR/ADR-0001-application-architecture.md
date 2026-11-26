# ADR-0001: Application Architecture

- **Status**: Accepted
- **Date**: 2026-11-26

## Context

Cross-platform mobile app targeting worldwide distribution on Google Play and the Apple App Store, free at launch, guest-first access. The stack must be fixed once and reused for every project the owner builds with this template.

## Decision

Adopt a three-tier architecture with fixed technology choices:

| Layer | Technology |
| --- | --- |
| Frontend | Flutter + Dart |
| Backend | FastAPI + Python |
| Auth & database | Supabase (Auth, PostgreSQL, Storage, RLS) |
| Source control & CI | Git + GitHub + GitHub Actions |

Firebase is explicitly excluded from the approved architecture. Supabase is the primary backend infrastructure; application-specific analytics are built on Flutter → FastAPI → Supabase rather than a third-party analytics dependency. Sentry is the preferred candidate for crash monitoring; PostHog is optional and requires owner approval.

## Consequences

- One skill set and one repository template across projects.
- Guest-first access maps naturally onto Supabase anonymous auth (ADR-0002).
- Team/off-the-shelf observability comes from Supabase's built-in logs/metrics; product analytics are self-built and privacy-classified from day one.
- Any future stack change requires a new ADR — these choices are not renegotiated per feature.
