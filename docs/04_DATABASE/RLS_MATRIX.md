# RLS_MATRIX

Who can access which data. RLS is an additional security boundary on top of FastAPI authorization (`AGENTS.md` §7). Every table gets a row here when it is created, and every policy gets a test in `supabase/tests/`.

Roles: `anon` (unauthenticated — not used in practice, app always has a session), `authenticated` (any Supabase session, **including anonymous guest users**), `service_role` (FastAPI server only, bypasses RLS).

| Table | anon | authenticated (owner) | authenticated (non-owner) | service_role | Notes |
| --- | --- | --- | --- | --- | --- |
| profiles | none | full CRUD on own row | read display_name only (if feature requires) | full | `id = auth.uid()` |
| analytics_events | none | insert own (`user_id = auth.uid()`); **no select/update/delete** | none | full | Writes come via FastAPI (service_role); client-side insert allowed only if catalog permits |
| *app tables* | — | — | — | — | *Awaiting app plan* |

## Standing rules

1. RLS is **enabled by default** on every table in `public`; a table without a policy is inaccessible to clients — that is the safe state.
2. Owner checks use `auth.uid()`; guest users have real `auth.users` rows, so the same policies cover guests and registered users.
3. Anonymous sessions never grant access to another user's rows — there is no "anonymous can see everything" policy.
4. Storage buckets: same principle — owner-scoped paths (`{user_id}/...`) with per-object policies.
5. Any policy change ships with: migration file, updated matrix row, and an RLS test proving both the allowed and the denied path.
6. Privileged operations (cross-user aggregation, deletion orchestration) run through FastAPI with `service_role`, never through client policies.
