-- Seed data for the DEVELOPMENT environment only.
-- Never run against staging or production (AGENTS.md §7).

-- Development helper: a test profile fixture. auth.users rows are created by
-- the auth flows themselves (anonymous sign-in, Google/Apple OAuth), so seeds
-- here only cover public-table data that assumes an existing dev user.
--
-- Usage:
--   1. Sign in once in the dev app (creates auth user + profile via trigger).
--   2. Optionally adjust profile fields below with that user's id.

-- update public.profiles
-- set display_name = 'Dev Tester'
-- where id = '00000000-0000-0000-0000-000000000000';  -- replace with dev user id
