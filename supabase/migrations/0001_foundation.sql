-- 0001: Foundation schema — profiles + analytics_events with RLS.
--
-- Deliberately minimal: application-specific entities are added ONLY after
-- the app plan (reference_material/APP_PLAN/) is analyzed (AGENTS.md §10).
-- Matches docs/04_DATABASE/DATABASE_SCHEMA.md and RLS_MATRIX.md.

-- ---------------------------------------------------------------- profiles
create table if not exists public.profiles (
    id           uuid primary key references auth.users (id) on delete cascade,
    display_name text,
    is_anonymous boolean not null default true,
    linked_at    timestamptz,
    created_at   timestamptz not null default now(),
    updated_at   timestamptz not null default now()
);

comment on table public.profiles is
    'One row per identity (guest or registered). Created by trigger on auth.users insert.';

-- Auto-create a profile for every new auth user (guests and registered alike).
create or replace function public.handle_new_user()
returns trigger
language plpgsql
security definer set search_path = public
as $$
begin
    insert into public.profiles (id, is_anonymous)
    values (new.id, new.raw_user_meta_data ->> 'is_anonymous_user' = 'true')
    on conflict (id) do nothing;
    return new;
end;
$$;

drop trigger if exists on_auth_user_created on auth.users;
create trigger on_auth_user_created
    after insert on auth.users
    for each row execute function public.handle_new_user();

-- updated_at maintenance
create or replace function public.touch_updated_at()
returns trigger
language plpgsql
as $$
begin
    new.updated_at = now();
    return new;
end;
$$;

drop trigger if exists profiles_touch_updated_at on public.profiles;
create trigger profiles_touch_updated_at
    before update on public.profiles
    for each row execute function public.touch_updated_at();

-- -------------------------------------------------------- analytics_events
create table if not exists public.analytics_events (
    id          bigint generated always as identity primary key,
    user_id     uuid references auth.users (id) on delete set null,
    event_name  text not null,
    properties  jsonb not null default '{}'::jsonb,
    occurred_at timestamptz not null,
    created_at  timestamptz not null default now()
);

create index if not exists analytics_events_name_time_idx
    on public.analytics_events (event_name, occurred_at desc);

comment on table public.analytics_events is
    'Product analytics intake. Validated against docs/10_OPERATIONS/ANALYTICS_EVENT_CATALOG.md; unknown events are dropped by the API.';

-- ------------------------------------------------------------------------- RLS
-- Safe default: RLS on, no policy = inaccessible to clients (RLS_MATRIX.md).

alter table public.profiles enable row level security;
alter table public.analytics_events enable row level security;

-- profiles: owner full access; non-owners may read display_name only.
drop policy if exists "profiles owner full" on public.profiles;
create policy "profiles owner full"
    on public.profiles
    for all
    to authenticated
    using (auth.uid() = id)
    with check (auth.uid() = id);

-- analytics_events: clients may insert their own; no read/update/delete
-- (reads happen via FastAPI service_role / rollup tables).
drop policy if exists "analytics insert own" on public.analytics_events;
create policy "analytics insert own"
    on public.analytics_events
    for insert
    to authenticated
    with check (auth.uid() = user_id);
