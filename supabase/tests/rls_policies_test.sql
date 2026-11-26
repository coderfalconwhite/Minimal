-- RLS policy tests (Part 1 requirement — docs/08_TESTING/TEST_STRATEGY.md).
--
-- Every policy must be proven on BOTH paths: allowed and denied.
-- Run against a disposable/local Supabase project, never production.
--
-- Supabase provides database-level testing helpers (pgTAP-style or the
-- `select set_config('request.jwt.claims', ...)` impersonation pattern).
-- The tests below use the standard impersonation pattern: switch the
-- authenticated role + jwt claims to a specific user id, then assert.

begin;

-- Fixture: two fake auth users + profiles (upsert-safe).
insert into auth.users (id, email, encrypted_password, aud, role, email_confirmed_at, created_at, updated_at)
values
  ('11111111-1111-1111-1111-111111111111', 'owner@test.dev', 'x', 'authenticated', 'authenticated', now(), now(), now()),
  ('22222222-2222-2222-2222-222222222222', 'other@test.dev', 'x', 'authenticated', 'authenticated', now(), now(), now())
on conflict (id) do nothing;

-- ---------------------------------------------------------------- profiles
-- Allowed: owner reads own row.
select set_config('request.jwt.claims',
  json_build_object('sub', '11111111-1111-1111-1111-111111111111', 'role', 'authenticated')::text,
  true);

do $$
declare
  cnt int;
begin
  select count(*) into cnt from public.profiles where id = '11111111-1111-1111-1111-111111111111';
  if cnt < 1 then
    raise exception 'RLS FAIL: owner cannot read own profile';
  end if;
end $$;

-- Denied: non-owner cannot read another user's row directly.
select set_config('request.jwt.claims',
  json_build_object('sub', '22222222-2222-2222-2222-222222222222', 'role', 'authenticated')::text,
  true);

do $$
declare
  cnt int;
begin
  select count(*) into cnt from public.profiles where id = '11111111-1111-1111-1111-111111111111';
  if cnt <> 0 then
    raise exception 'RLS FAIL: non-owner can read another profile';
  end if;
end $$;

-- -------------------------------------------------------- analytics_events
-- Allowed: user inserts own event.
select set_config('request.jwt.claims',
  json_build_object('sub', '22222222-2222-2222-2222-222222222222', 'role', 'authenticated')::text,
  true);

insert into public.analytics_events (user_id, event_name, properties, occurred_at)
values ('22222222-2222-2222-2222-222222222222', 'screen_view', '{"screen_name":"test"}'::jsonb, now());

-- Denied: user cannot read events back.
do $$
declare
  cnt int;
begin
  select count(*) into cnt from public.analytics_events;
  if cnt <> 0 then
    raise exception 'RLS FAIL: client can read analytics_events';
  end if;
end $$;

-- Denied: user cannot insert events for another user.
do $$
begin
  begin
    insert into public.analytics_events (user_id, event_name, properties, occurred_at)
    values ('11111111-1111-1111-1111-111111111111', 'screen_view', '{}'::jsonb, now());
    raise exception 'RLS FAIL: user can insert analytics for another user';
  exception
    when raise_exception then raise;
    when insufficient_privilege then null; -- expected: policy violation
    when check_violation then null;
  end;
end $$;

rollback;
