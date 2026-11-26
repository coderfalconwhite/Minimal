# SKILL — flutter-mobile-engineering

Flutter architecture, Dart practices and cross-platform development.

## When to use

Any work in `apps/mobile/` — screens, features, state, navigation, platform behavior, dependencies.

## Architecture (fixed)

Feature-first under `apps/mobile/lib/`:

- `core/` — config, networking (Dio), authentication, routing (GoRouter), errors, logging, storage, theme, common_widgets.
- `features/<name>/` — the feature's screens, state (Riverpod providers), business rules, models, repositories.
- Screens never talk to database internals directly; features never reach into each other's internals (go through `core/` or a shared contract).

Full description: `docs/02_FRONTEND/FRONTEND_ARCHITECTURE.md`. Decisions: ADR-0004 (state), ADR-0005 (API communication).

## Practices

- **Dependencies**: start from Riverpod / GoRouter / Dio / supabase_flutter / flutter_secure_storage. Validate compatible versions together before adding; record additions in `pubspec.yaml` with a comment on why.
- **Every screen**: six states (loading, empty, error, success, disabled, offline), responsive layouts, text scaling, touch feedback, platform conventions (Android/iOS), accessibility semantics.
- **Async & errors**: typed failures from `core/errors`; user-friendly messages; no swallowed exceptions; loading states never freeze the UI.
- **Forms & keyboard**: proper input types, validation feedback, keyboard avoidance, focus handling.
- **Local persistence**: secure storage for session-related data; nothing sensitive in shared prefs / plain files.
- **No secrets in the app**: anon key only; service_role/secrets never appear in Dart code or assets.
- **Tests**: widget test per screen (render + actions + error/empty); unit tests for feature logic; run `flutter analyze` and `dart format` before every commit.

## Cross-platform notes

- Platform-specific behavior (haptics, transitions, back handling) via platform checks, kept out of feature widgets.
- Android/iOS OAuth redirect configuration is prepared in code, but native SDK/build environments are Part 3 — code must be structured to compile and test when that tooling arrives.

## Definition of done

`flutter analyze` clean · `dart format --set-exit-if-changed` clean · tests green · screen wired into GoRouter and `SCREEN_ACTION_BACKEND_MAP.md` · states all implemented · docs updated.
