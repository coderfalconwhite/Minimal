# ANALYTICS_EVENT_CATALOG

Every analytics event the product may collect: name, purpose, properties, retention, privacy classification. The FastAPI intake validates events against this catalog and drops unknown ones. Adding an event = updating this file (change control — `AGENTS.md` §11) before shipping the code that sends it.

Privacy classes: `P0 aggregate` (no user content) · `P1 behavioral` (tied to user/session ID, no content) · `P2 content-adjacent` (references user content by ID, never content itself). Sensitive user input is never an event property.

## Standard events (stack-level)

| Event | Purpose | Properties | Retention | Class |
| --- | --- | --- | --- | --- |
| `screen_view` | Which screens are visited most | `screen_name`, `referrer_screen` | 12 months | P1 |
| `screen_duration` | Active foreground time per screen | `screen_name`, `active_seconds` (foreground only) | 12 months | P1 |
| `scroll_milestone` | How far users scroll (25/50/75/100 only — never per-scroll) | `screen_name`, `milestone` | 6 months | P0 |
| `feature_used` | Which features users actually use | `feature_id` | 12 months | P1 |
| `search_performed` | Popular & zero-result searches | `query_length_bucket`, `results_count` (P2 only if query itself is approved for collection — default: no raw query) | 6 months | P1 |
| `content_opened` | Most-viewed listings/posts | `content_type`, `content_id` | 6 months | P2 |
| `content_action` | Opens/saves/shares engagement | `content_type`, `content_id`, `action` | 6 months | P2 |
| `session_start` | Retention (D1/D7/D30), journey analysis | none | 24 months | P1 |
| `api_error` | Failed/slow operations monitoring | `endpoint`, `status_code`, `duration_bucket` | 3 months | P0 |

## App-specific events

| Event | Purpose | Properties | Retention | Class |
| --- | --- | --- | --- | --- |
| — | *Awaiting app plan* | | | |

## Intake rules

1. Batched only (`POST /api/v1/analytics/events`, ≤50 events, milestones not per-scroll).
2. `user_id` filled server-side from the verified JWT — never trusted from the payload.
3. Events not in this catalog are dropped and counted (`analytics_dropped_total`).
4. Retention jobs run per the retention column; definitions land in migrations before production enablement.
5. Aggregate dashboards (admin) read from rollup tables, not raw events, wherever practical.
