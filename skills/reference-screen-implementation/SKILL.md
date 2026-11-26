# SKILL — reference-screen-implementation

Analyze reference screenshots and produce production-quality Flutter screens.

## When to use

Whenever a screen from `reference_material/REFERENCE_SCREENS/` is being analyzed, planned, or implemented.

## Procedure (mandatory, in order)

1. **Analyze the provided original image.**
2. **Identify layout hierarchy, spacing, typography and component structure** — break the screen into widgets: scaffolds, app bars, lists/grids, cards, inputs, buttons, FABs, bottom sheets, navigation elements.
3. **Identify interactions and navigation** — every tappable element: what it does, where it navigates, what data it sends.
4. **Identify loading, empty, error and disabled states** — plus success and offline. If the screenshot shows only the happy path, design the other states (see State requirements).
5. **Implement the screen using the established Flutter architecture** (`docs/02_FRONTEND/FRONTEND_ARCHITECTURE.md`): feature-first folders, Riverpod state, GoRouter routing, real repositories. Never an isolated demo screen disconnected from navigation/auth/logic.
6. **Compare the implementation against the reference** — side-by-side check of layout, spacing, hierarchy.
7. **Improve usability without making arbitrary design changes.** Design improvement is permitted; product behavior and intended design direction must be preserved unless an improvement is justified and documented. Every improvement goes into `docs/02_FRONTEND/UI_IMPROVEMENT_PROPOSALS.md` **before** building, and the product owner chooses improved vs faithful default.
8. **Test different screen sizes** — small phone, large phone, tablet breakpoints; text scaling; light/dark if themed.
9. **Update the reference-to-implementation mapping** — `docs/02_FRONTEND/SCREEN_ACTION_BACKEND_MAP.md`.

## State requirements (every screen)

| State | Must show |
| --- | --- |
| Loading | Skeleton/spinner, not a frozen frame |
| Empty | Explanation + next action |
| Error | Human message + retry |
| Success | Confirmation where an action completed |
| Disabled | Visually distinct unavailable actions |
| Offline | Connection-loss awareness, queued/retry behavior |

## Hard rules

- No decorative elements, unnecessary animations, oversized cards, or visual additions that do not improve usability.
- No placeholder data declared "complete"; every button performs its intended action connected to real logic and backend.
- Accessibility: semantics labels, contrast, text scaling, touch targets ≥ 44/48pt.
- Widget test per screen covering at minimum: render, each action, error and empty states.

## Output artifacts

Updated `SCREEN_ACTION_BACKEND_MAP.md` row, widget test file, and (if proposing improvements) entries in `UI_IMPROVEMENT_PROPOSALS.md`.
