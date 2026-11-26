# SKILL — store-compliance

Apple, Google Play and worldwide privacy requirements.

## When to use

Feature planning (privacy/store implications), account/profile work, permission usage, release preparation, or any change that affects data collection, login, deletion, payments, or content.

## Authoritative documents

`docs/07_PRIVACY_COMPLIANCE/STORE_COMPLIANCE.md` (requirements + check dates) · `DATA_INVENTORY.md` · `PRIVACY_AND_DELETION.md` · `docs/09_DEPLOYMENT/RELEASE_CHECKLIST.md`.

## Core principle

**There is no universal configuration that guarantees approval.** Approval depends on the app's actual functionality, data handling, content, business model, and metadata against *current* policies. This skill makes compliance part of the architecture, then re-verifies against official sources before each submission (record URL + last-checked date).

## Standing requirements (both stores)

- **Sign in with Apple on iOS** whenever Google login is offered (Apple Guideline 4.8 — equivalent privacy-preserving login).
- **In-app account deletion** that really deletes (never deactivation-only): Supabase Auth user, records, files, third-party tokens (Apple revocation included).
- **External deletion web page** for Google Play, URL registered in Play Console (`legal_web/account-deletion/`).
- **Accurate privacy declarations**: Google Data safety + Apple privacy labels must match `DATA_INVENTORY.md` and actual SDK behavior.
- **Privacy policy** accessible in-app and in listings, covering collection, use, sharing, retention, deletion.
- **Google Play closed test**: personal accounts created after 2023-11-13 generally need ≥12 testers for 14 continuous days before production — confirm the owner's account type early.

## Per-feature checks

When a feature is proposed, answer:

1. Does it add data collection? → `DATA_INVENTORY.md` row + declarations.
2. New permission? → `DEVICE_CAPABILITY_MATRIX.md` + user-facing justification.
3. Payments / digital goods? → payment architecture review **before** implementation.
4. User-generated content? → reporting, moderation, blocking, safety flows.
5. Children/age-sensitive? → age rating and extra requirements.
6. Third-party SDK? → its data practices documented before adoption.
7. IP rights clear for all assets and trademarks?

## Submission time

Run `RELEASE_CHECKLIST.md` end-to-end; prepare review access (working backend, demo account for Apple); verify every policy URL's check date is recent.
