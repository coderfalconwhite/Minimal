# PRIVACY_AND_DELETION

Consent, retention, deletion, and privacy procedures. Companion to `DATA_INVENTORY.md` (what is collected) — this file governs what happens to it.

## Consent

- Guest-first means most data is tied to an anonymous ID with no personal identifiers — but it is still user data and still governed by this file.
- Analytics events carry a documented purpose and privacy classification (`docs/10_OPERATIONS/ANALYTICS_EVENT_CATALOG.md`); unknown events are dropped by the API.
- If/when consent-requiring features arrive (e.g. notifications, marketing), consent state is recorded per user with timestamp and scope.
- Analytics collection must respect user consent choices and applicable privacy requirements (`AGENTS.md` §9).

## Retention

| Data | Retention |
| --- | --- |
| Account record (registered) | Until account deletion |
| Anonymous guest account | Until user-initiated deletion **or** cleanup policy for stale anonymous accounts (Supabase does not remove them automatically — a scheduled cleanup job is planned) |
| User-generated data | Until deletion |
| Analytics events | Per event-class policy defined before production analytics enablement |
| Crash reports | Per monitoring provider's policy, reviewed before adoption |
| Operational logs | Separate from product analytics; standard ops retention |

## Deletion procedure (single authoritative workflow)

Triggered in-app (both stores require an in-app path) or via the external web page (`legal_web/account-deletion/`, URL registered in Play Console).

1. User requests deletion; app shows what will be deleted and asks for confirmation.
2. FastAPI `POST /me/delete-account` orchestrates (server-side, audit-logged):
   - app-specific database records (cascade via FKs where designed),
   - user-uploaded files in Supabase Storage,
   - revocation of third-party tokens — **Sign in with Apple token revocation included** (Apple requirement),
   - the Supabase Auth user itself (account is deleted, not deactivated),
   - retention exceptions only where legitimately disclosed (e.g. legal obligations) — these are listed in the privacy policy.
3. Guest data reset/deletion follows the same path for anonymous users.

Deletion is a real deletion. "Deactivation" does not satisfy either store.

## Privacy policy & legal pages

- Privacy policy (collection, use, third-party sharing, retention, deletion): `legal_web/privacy-policy/` — must be accessible in-app and in the store listings.
- Terms: `legal_web/terms/`.
- Account deletion web page: `legal_web/account-deletion/`.
- These pages stay in sync with `DATA_INVENTORY.md`; a mismatch is a rejection and trust risk.

## Guest-data safeguards

- Guest limitations explained in-app (anonymous identity is lost on sign-out/data clear/device change unless linked).
- Linking never silently overwrites data belonging to an existing account (see `AUTH_FLOW.md`).
