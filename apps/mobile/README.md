# Mobile App (Flutter)

Cross-platform mobile application. Stack: Flutter + Dart, Riverpod (state), GoRouter (navigation), Dio (HTTP), supabase_flutter (auth/DB client). See `docs/02_FRONTEND/FRONTEND_ARCHITECTURE.md` and `AGENTS.md`.

## Structure

```
lib/
├── core/            config, networking, authentication, routing, errors,
│                    logging, storage, theme, common_widgets
├── features/        onboarding, authentication, home, profile,
│                    other_app_features (split per app plan)
└── main.dart
test/                widget & unit tests
assets/              images/fonts (from reference_material/DESIGN_ASSETS)
```

## Commands

```bash
flutter pub get
dart format --set-exit-if-changed .
flutter analyze
flutter test
```

## Status

Scaffold only — every `lib/` file is a documented placeholder awaiting the app plan (`reference_material/APP_PLAN/`). No screens implemented yet.

## Rules (short version — AGENTS.md is authoritative)

- Anon key only; `service_role` and OAuth secrets never appear here.
- Every screen: loading/empty/error/success/disabled/offline states, responsive, accessible, tested.
- No isolated demo screens; everything wired into the real architecture.
- Reference screenshots are the design source — improvements go through `UI_IMPROVEMENT_PROPOSALS.md` first.
