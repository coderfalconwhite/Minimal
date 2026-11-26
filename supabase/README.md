# Supabase

Migrations, seed data, and database tests. Auth/DB/Storage/RLS live in the Supabase project; policies and schema are version-controlled here (`AGENTS.md` §7). Docs: `docs/04_DATABASE/DATABASE_SCHEMA.md` · `RLS_MATRIX.md`.

## Structure

```
migrations/   forward-only, NNNN_description.sql, tested on a fresh DB before merge
seed/         development-only fixtures (never staging/production)
tests/        RLS policy tests (allowed AND denied paths)
```

## Commands

```bash
supabase login
supabase link --project-ref <dev-project-ref>
supabase db push                 # apply pending migrations to the linked (dev) project
supabase db reset                # local: recreate schema + seed from scratch
```

## Rules

1. **Environment separation**: link only the development project for day-to-day work; staging/production pushes are deliberate, logged actions — automated tasks never touch production.
2. **RLS tests** (`tests/rls_policies_test.sql`) run before any policy change merges; both allowed and denied paths must pass.
3. **Migrations are immutable once applied** to a shared environment — corrections are new migrations.
4. Application-specific tables are added only after the app plan is analyzed (never invented).
5. Project configuration checklist (Part 1): anonymous auth enabled · Google + Apple providers · manual linking enabled · CAPTCHA on anonymous sign-ins · redirect allow-lists tight.

## Current state

Migration `0001_foundation.sql` defines `profiles` (auto-created per auth user via trigger, covers guests and registered users) and `analytics_events` (intake table, insert-only for clients) with RLS enabled on both.
