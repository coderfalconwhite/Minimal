# DATA_INVENTORY

Exactly what information the application and its SDKs collect. This is the source of truth for Google's Data safety declaration, Apple's privacy labels, and the privacy policy. Updated through change control whenever a feature or SDK changes data collection.

## Data categories

| Category | What is collected | Purpose | Stored where | Retention | Shared with | Status |
| --- | --- | --- | --- | --- | --- | --- |
| Account information | Email, name, provider identity (Google/Apple) — only when the user registers | Account & session | Supabase Auth | Until account deletion | Nobody (auth provider only) | planned |
| Guest identity | Anonymous user ID | Guest sessions & data ownership | Supabase Auth | Until deletion or cleanup policy | Nobody | planned |
| User-generated data | *Awaiting app plan* (posts/listings/uploads?) | App functionality | Supabase DB/Storage | Until deletion | Nobody | TBD |
| Device information | *TBD — list exact SDK-collected data (e.g. OS version, locale)* | Compatibility & diagnostics | TBD | TBD | TBD | TBD |
| Analytics | Screen views, feature usage, scroll milestones, search terms (see `ANALYTICS_EVENT_CATALOG.md`) | Product improvement | Supabase PostgreSQL | Per event-class policy | Nobody | planned |
| Crash reports | Error & crash diagnostics (Sentry candidate — privacy review first) | Stability | Sentry (if adopted) | TBD | Sentry | proposed |
| Location | **Precise: never for analytics.** Coarse/user-selected region only if a feature requires it | TBD | TBD | TBD | TBD | TBD |
| Storage | User-uploaded images/files if the app plan includes them | App functionality | Supabase Storage | Until deletion | Nobody | TBD |

## Rules

1. Every new data flow lands in this table in the same PR that introduces it.
2. SDK data practices are documented when the SDK is adopted (check each SDK's own disclosures).
3. The Data safety declaration and privacy labels must **match this table** — mismatch is a rejection risk.
4. Data collected "just in case" is forbidden; each row names a purpose.
5. Sensitive user input is never collected for analytics (`AGENTS.md` §9).
