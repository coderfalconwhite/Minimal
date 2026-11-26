# Frontend Architecture (Flutter)

## Feature-first structure

```
apps/mobile/lib/
├── core/
│   ├── config/          environment & app configuration
│   ├── networking/      Dio client, interceptors, API errors
│   ├── authentication/  session handling, auth state
│   ├── routing/         GoRouter configuration
│   ├── errors/          error types & mapping
│   ├── logging/         structured logging
│   ├── storage/         secure local persistence
│   ├── theme/           design tokens, light/dark
│   └── common_widgets/  shared widgets
├── features/
│   ├── onboarding/
│   ├── authentication/
│   ├── home/
│   ├── profile/
│   └── other_app_features/   → renamed/split per app plan
└── main.dart
```

Each feature owns its screens, state, business rules, data models, and repositories. Screens never talk to database internals directly, and the app is never collapsed into a single large folder.

## Recommended tooling (starting points — validate versions before committing; record in ADR-0004/0005)

| Concern | Package | Notes |
| --- | --- | --- |
| State management | Riverpod | |
| Navigation | GoRouter | deep links, guards (auth) |
| HTTP | Dio | interceptors attach Supabase access token |
| Auth/DB client | supabase_flutter | anonymous, Google, Apple, RLS reads |
| Secure storage | flutter_secure_storage | session/keys |

## Screen implementation requirements (every screen)

- Responsive layouts across phone dimensions; adaptive navigation where appropriate.
- Android/iOS platform conventions respected.
- Proper touch feedback and transitions; animations only where they aid usability.
- All six states: empty, loading, error, success, disabled, offline.
- Accessibility and text scaling.
- Keyboard and form handling.
- Widget tests; screen/navigation tests.
- Wired into the real architecture: real navigation, real logic, real backend calls. No isolated demo screens, no placeholder data declared complete.

## Reference screens

Design source: `reference_material/REFERENCE_SCREENS/` — procedure in `AGENTS.md` §3. Improvements are proposed in `UI_IMPROVEMENT_PROPOSALS.md` and built only after the product owner chooses improved vs faithful default.

See also: `SCREEN_ACTION_BACKEND_MAP.md` (this folder).
