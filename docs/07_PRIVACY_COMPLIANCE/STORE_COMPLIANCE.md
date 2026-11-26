# STORE_COMPLIANCE

Requirements for Google Play and the Apple App Store. Compliance is an engineering responsibility from Part 1 — not a submission-day activity. **There is no universal configuration that guarantees approval**; every item below must be checked against the app's actual functionality, data handling, content, business model, and metadata, against the *current* store policies.

## How this file is maintained

Every requirement row carries a **source URL** and a **last-checked date**. The agent re-checks official policy pages before each submission and updates dates. Policies change — a rule verified last quarter may have moved.

## Authentication

| Requirement | Store | Status | Last checked |
| --- | --- | --- | --- |
| Apps offering third-party/social login for the primary account must also offer a privacy-preserving alternative (Apple Guideline 4.8) → Sign in with Apple ships on iOS alongside Google | Apple | planned (F-003) | 2026-11-26 |
| Apple login uses nonce handling and registered identifiers | Apple | planned | 2026-11-26 |

## Account deletion

| Requirement | Store | Status |
| --- | --- | --- |
| In-app account deletion initiation (not mere deactivation) | Apple + Google | planned (F-009) |
| Sign in with Apple tokens revoked on deletion | Apple | planned |
| External web page to initiate deletion, URL registered in Play Console | Google | planned (`legal_web/account-deletion/`) |
| Associated user data deleted, subject to disclosed retention needs | Google | planned |

Full procedure: `PRIVACY_AND_DELETION.md`.

## Privacy & data

| Requirement | Store | Status |
| --- | --- | --- |
| Accurate Data safety declaration matching app + SDK behavior | Google | planned — filled from `DATA_INVENTORY.md` |
| Privacy policy accessible in-app and in the Play listing | Google | planned |
| Privacy policy explaining collection, use, sharing, retention, deletion | Apple | planned |
| App privacy "nutrition labels" matching actual collection | Apple | planned |

## Policy areas to check against the app plan

Each becomes concrete once the app plan exists: payments/subscriptions · user-generated content (reporting, moderation, blocking) · camera/microphone permissions · location · notifications · children's content & age rating · external links · third-party SDK data practices · intellectual property rights.

If the app ever sells digital goods/subscriptions, the payment architecture is reviewed **before** implementation, not after.

## App review preparation

- Apple: review team needs a working backend, complete functionality, and demo access where needed. Never submit with broken features or inaccessible account-based features.
- Google Play: personal developer accounts created after 2023-11-13 generally need a **closed test with ≥12 testers opted in continuously for 14 days** before production access (may not apply to organization accounts). *Owner must confirm their account type and creation date.*

## Submission checklist

Maintained in `docs/09_DEPLOYMENT/RELEASE_CHECKLIST.md`.

## Open owner decisions

Google Play account creation date & type · Apple Developer account status · target age group · initial languages — all recorded in `PROJECT_STATE.md` until answered.
