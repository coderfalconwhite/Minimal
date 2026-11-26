# AGENTS.md — Universal Agent Instructions

This file contains the universal development rules for this project. Every agent (GLM / ZCode or human contributor) MUST read this file and `PROJECT_STATE.md` before doing any work.

---

## 1. Project Identity

Cross-platform mobile application.

| Layer | Technology (FIXED — never changes between projects) |
| --- | --- |
| Frontend | Flutter + Dart |
| Backend | FastAPI + Python |
| Authentication | Supabase Auth |
| Database | Supabase PostgreSQL |
| Access model | Guest first, optional login |
| Monetization | Free, no paid features at launch |
| Distribution | Worldwide (Google Play + Apple App Store) |
| Source control | Git + GitHub |
| CI | GitHub Actions |

These choices are permanent. Do not propose or introduce replacements (no Firebase, no different backend, no different state library) without an approved ADR.

---

## 2. How the agent must load its information

1. Always read `AGENTS.md` and `PROJECT_STATE.md` before working.
2. Inspect the current Git status and relevant code.
3. Read only the documentation relevant to the assigned task.
4. Load the appropriate `skills/*/SKILL.md` when working on Flutter, FastAPI, authentication, security, testing, or UI.
5. Never assume an undocumented feature is implemented.
6. Record important decisions in Architecture Decision Records (`docs/ADR/`).
7. Update `PROJECT_STATE.md` and `CHANGELOG.md` after completing work.
8. Never report a feature as complete without appropriate verification.

---

## 3. The workflow the agent must follow

When the user supplies an app idea, plan, and/or screenshots in `reference_material/`:

1. **Read the app idea and plan** — understand the problem, objectives, target users, required features and constraints.
2. **Analyze every supplied screenshot** — identify screens, buttons, actions, navigation, data, user journeys and possible OS permissions.
3. **Generate app-specific Markdown documentation** — screen inventories, API mappings, database plans, permissions, backend requirements, feature backlogs and other necessary documents. Write them into the existing files in this repository (never into new ad-hoc locations).
4. **Develop the frontend in Flutter** — reproduce the supplied screen designs in Dart, maintain the intended experience, implement real navigation and UI states.
5. **Present UI improvement suggestions** — generate `docs/02_FRONTEND/UI_IMPROVEMENT_PROPOSALS.md` and **ASK the user** to accept, reject or defer each suggestion before building. **Do not start building UI until the user answers whether to use the improved UI/UX or the default (faithful-to-screenshot) one.**
6. **Develop the backend** — after the user's decision, implement FastAPI, Supabase, authentication, database, API connections, storage, permissions and other justified services.
7. **Implement analytics and monitoring** — track approved user interactions, screen usage, content engagement and operational errors.
8. **Maintain project history** — update documentation, feature versions, changelog, tests and project state whenever changes occur.

### Working with reference screens (mandatory procedure)

`reference_material/` is the product-design source, not disposable assets. For every screen provided:

1. Understand the screen's purpose.
2. Identify its layout, components, spacing, typography, colors, and navigation.
3. Identify the user interactions.
4. Identify empty, loading, error, success, and disabled states.
5. Compare the reference against the product requirements.
6. Improve the design where appropriate without changing the intended functionality.
7. Implement the final screen in Flutter using the established architecture.
8. Connect its interactions to actual application logic and backend services.
9. Test at different screen sizes.
10. Update the reference-to-implementation mapping (`SCREEN_ACTION_BACKEND_MAP.md`).

Do not blindly copy a screenshot; do not freely redesign the app into something unrelated to the reference.

**UI/UX rule:** Design improvement is permitted; product behavior and the intended design direction must be preserved unless an improvement is justified and documented. Avoid decorative elements, unnecessary animations, oversized cards, and other visual additions that do not improve usability.

---

## 4. Responsibility boundaries

### Supabase
- User registration and authentication (guest/anonymous, Google, Apple).
- Session management and token refresh.
- PostgreSQL database and Row Level Security (RLS).
- File storage where required.
- Platform observability (logs, metrics, reports).

### FastAPI
- Application business logic.
- API endpoints (versioned).
- Server-side validation and authorization.
- Complex database operations.
- External API integrations.
- Background processing and scheduled jobs when needed.
- Application-specific analytics processing.

### Flutter
- User interface and interactions.
- Authentication screens.
- Session management on device.
- API communication.
- Local state and application navigation.

Avoid duplicating business logic across Flutter, FastAPI, and database functions.

---

## 5. Universal development rules

| Rule | Required agent behavior |
| --- | --- |
| Understand before modifying | Inspect relevant architecture and source files |
| Plan substantial changes | Explain intended files and dependencies |
| Preserve existing functionality | Avoid unrelated rewrites |
| Respect reference material | Do not redesign arbitrarily |
| Production-quality code | No demo-only implementations |
| Backend integration | No fake API success responses |
| Security | Validate identities and permissions |
| Database | Use version-controlled migrations |
| Testing | Test every meaningful change |
| Bug fixing | Identify root causes, not just symptoms |
| Documentation | Update project state and relevant documents |
| Git | Review changes and avoid destructive commands |
| Completion reports | Show actual changes and verification results |

---

## 6. Mandatory task completion protocol

Every substantial task must follow this process:

```
Understand task
  → Inspect project state
  → Read relevant documentation and skills
  → Inspect affected code
  → Identify dependencies and risks
  → Prepare implementation plan
  → Implement changes
  → Run relevant tests
  → Fix discovered failures
  → Perform regression checks
  → Review security implications
  → Update documentation
  → Update PROJECT_STATE.md
  → Report verified results
```

The agent must never say something works simply because it wrote the code.

---

## 7. Security rules (non-negotiable)

1. **FastAPI must verify the Supabase access token** rather than trusting a user ID sent by Flutter. Validate the token's signature, issuer, audience, and expiration using Supabase's JWKS endpoint (`https://<project>.supabase.co/auth/v1/.well-known/jwks.json`).
2. **Never put a Supabase `service_role` key, Apple client secret, Google client secret, or GLM API key inside the Flutter application.** Keep privileged credentials on the server only.
3. Use **RLS as an additional security boundary** for user-owned database and storage data.
4. Implement **account deletion** (App Store / Play Store requirement): Supabase Auth user, profile, database records, uploaded files, and connected third-party services.
5. Keep development, staging, and production Supabase projects **separate**. Never use the production database as a development playground. Never let an automated coding task modify production data or credentials casually.
6. When Sign in with Apple is used, revoke associated tokens on account deletion (Apple requirement).
7. Supabase Anonymous (guest) identities are not recoverable accounts. Implement persistent guest sessions, a clear explanation of guest-data limitations, an account-linking option in Settings, safe handling of existing-account conflicts, explicit data migration/merging rules, and a way to reset or delete guest data. Never silently transfer or overwrite guest data when a Google/Apple identity already belongs to another account.
8. Enable CAPTCHA protection for anonymous sign-ins (abuse protection) and maintain a retention/cleanup policy for anonymous accounts (Supabase does not clean them up automatically).

---

## 8. Authentication policy

| Requirement | Implementation |
| --- | --- |
| Guest access | Required |
| Google login | Optional |
| Apple login | Optional |
| Login before using basic features | No |
| Persistent guest session | Yes |
| Upgrade guest to registered user | Yes |
| User account deletion | Required |
| Guest data deletion | Required |
| Admin access | Restricted to authorized server operations |

Flow: User opens app → Login or registration → Google / Apple login → Supabase Auth verifies identity and establishes the session → FastAPI verifies the Supabase access token (JWKS) → Authorized access to application features.

Implement authentication **early (Part 1)**, not after the UI is finished: user profile creation, login persistence and session restoration, sign-out, authentication error handling, expired-session handling, account linking where appropriate, account deletion, authorization tests.

Use Supabase's supported native Google and Apple authentication flows for Flutter. Apple authentication uses nonce handling and requires the app's registered identifiers.

---

## 9. Backend and monitoring policy

1. Supabase is the primary backend infrastructure.
2. **Firebase is not part of the approved architecture.**
3. Use Supabase for: Authentication, PostgreSQL, Storage, Realtime, Row Level Security, backend and database observability.
4. Build application-specific analytics using: Flutter event tracking → FastAPI analytics services → Supabase PostgreSQL → aggregated analytics queries → private admin dashboards.
5. PostHog is optional and requires approval before integration.
6. Sentry is the preferred candidate for production crash and error monitoring. Evaluate its privacy and integration requirements before adoption.
7. Never collect unnecessary personal data, precise location, or sensitive user input for analytics. Do not request precise GPS solely to measure regional app popularity — use coarse or user-selected regions.
8. Every analytics event must have: an event name, a documented purpose, defined properties, a retention policy, and a privacy classification.
9. Maintain separate operational logs and product analytics.
10. Analytics collection must respect applicable privacy requirements and user consent choices.

Implementation detail: do not send an analytics request for every scroll movement. Capture meaningful milestones (25%, 50%, 75%, 100%) and batch events. Distinguish foreground active time from background time.

---

## 10. Development parts

- **Part 1 — Foundation** (start immediately): Git and environment verification; Flutter formatting and static analysis; FastAPI endpoints and unit tests; Supabase migration checks; authentication and JWT verification tests; RLS and authorization tests; automated GitHub Actions checks. Backend foundation: project skeleton, API versioning, config/env handling, Supabase configuration, JWT verification, guest/Google/Apple auth, schema + migrations (only for confirmed requirements), RLS, error handling, logging, tests, initial security checks. **Do not invent application-specific database entities before the app plan is supplied.**
- **Part 2 — Application development** (continuous): real screens from reference material, navigation, guest functionality, account linking, app-specific features, API communication, database integration, validation, error handling, offline states, local persistence, settings, profile management; widget/unit/feature/integration/regression/security tests; responsive layouts; accessibility and text scaling; keyboard and form handling. Every screen must be part of the real application architecture — no isolated demo screens, no placeholder data declared "complete".
- **Part 3 — Native and release** (deferred): Android SDK/NDK, Xcode on macOS, real-device testing, store compliance audit, monitoring, release builds.

Store compliance (start Part 1, implement throughout Part 2, verify in Part 3): see `docs/07_PRIVACY_COMPLIANCE/`.

---

## 11. Change control

When the user requests a new feature (e.g. "Add a notification feature"), update ALL of these files:

| File | What changes |
| --- | --- |
| `docs/00_PRODUCT/FEATURE_BACKLOG.md` | Register the new feature |
| `docs/00_PRODUCT/VERSION_PLAN.md` | Assign a proposed release |
| `docs/02_FRONTEND/SCREEN_ACTION_BACKEND_MAP.md` | Document the new controls |
| `docs/03_BACKEND/API_ENDPOINT_CATALOG.md` | Add required API contracts |
| `docs/04_DATABASE/DATABASE_SCHEMA.md` | Record required data changes |
| `docs/00_PRODUCT/DEVICE_CAPABILITY_MATRIX.md` | Document any new permission |
| `docs/10_OPERATIONS/ANALYTICS_EVENT_CATALOG.md` | Add relevant events |
| `CHANGELOG.md` | Record completed changes |
| `PROJECT_STATE.md` | Update current progress |

Every feature carries a status: **proposed → approved → implemented → tested → released.**
