# DATABASE_SCHEMA

Tables, relationships, constraints. Application-specific entities are added **only after** the app plan in `reference_material/APP_PLAN/` is analyzed — never invented. All changes go through version-controlled migrations in `supabase/migrations/`.

## auth (managed by Supabase)

`auth.users` — one row per identity (anonymous guest, Google, Apple, or linked). Managed by Supabase Auth; the app never writes to it directly.

## public (project tables)

### profiles (Part 1)

| Column | Type | Constraints | Notes |
| --- | --- | --- | --- |
| id | uuid | PK, references `auth.users(id) on delete cascade` | Same as the auth user |
| display_name | text | nullable | |
| is_anonymous | boolean | not null default true | Flipped on identity linking |
| linked_at | timestamptz | nullable | When a permanent identity was linked |
| created_at | timestamptz | not null default now() | |
| updated_at | timestamptz | not null default now() | Trigger-maintained |

Trigger: `on_auth_user_created` → insert a matching `profiles` row (handles guests and registered users uniformly).

### analytics_events (Part 1 skeleton)

| Column | Type | Constraints | Notes |
| --- | --- | --- | --- |
| id | bigint | PK identity | |
| user_id | uuid | nullable, references `auth.users(id) on delete set null` | Nullable to survive account deletion for aggregate stats |
| event_name | text | not null | Must exist in `ANALYTICS_EVENT_CATALOG.md` |
| properties | jsonb | not null default '{}' | Documented properties only |
| occurred_at | timestamptz | not null | Client-reported, server-clamped |
| created_at | timestamptz | not null default now() | |

Partitions/retention: define per event class before enabling analytics in production.

### App-specific tables

*Awaiting app plan.*

## Conventions

- Every table: `created_at` (+ `updated_at` where mutable), RLS enabled, owner references use `on delete cascade` (or documented exception).
- Migrations are forward-only, named `NNNN_description.sql`, and tested against a fresh database before merge.
- Schema changes are recorded here in the same PR that ships the migration (change control — `AGENTS.md` §11).

See `RLS_MATRIX.md` for access rules.
