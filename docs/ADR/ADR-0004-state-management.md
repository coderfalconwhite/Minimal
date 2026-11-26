# ADR-0004: State Management (Flutter)

- **Status**: Accepted (starting recommendation)
- **Date**: 2026-11-26

## Context

The Flutter app uses a feature-first architecture (`core/` + `features/`). State management must handle: auth/session state shared across features, per-feature screen state, async API data with loading/error states, and testability of every screen (widget tests are a Part 2 requirement).

## Decision

Use **Riverpod** for state management, with **GoRouter** for navigation and **Dio** for HTTP.

- Riverpod providers are organized per feature; `core/authentication` exposes the session/auth state consumed by routing guards and features.
- GoRouter redirects handle the guest-first flow: a session is restored on startup, and unauthenticated users land on the welcome screen (never a dead end).
- Dio interceptors attach the current Supabase access token to FastAPI requests and map API errors into typed failures (`core/errors`).
- Package versions are validated together (compatibility matrix) and recorded in `apps/mobile/pubspec.yaml` before first commit; upgrades go through review + regression tests.

These were chosen as starting recommendations, not eternal laws: replacing one requires a new ADR, but day-to-day work treats them as fixed.

## Consequences

- Compile-safe dependency injection; screens stay testable with overridden providers in widget tests.
- One auth-state source of truth feeding router, features, and networking.
- Compared to Bloc: less boilerplate for this scope; compared to Provider: better testability and no BuildContext coupling.
- Team must keep providers feature-scoped — a god-provider in `core/` is an anti-pattern to reject in review.
