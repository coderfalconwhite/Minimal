# SCREEN_ACTION_BACKEND_MAP

Reference-to-implementation mapping. One row per screen: what it shows, its actions, and which backend capability each action uses. The agent updates this map whenever a screen is implemented or a control changes (change control — `AGENTS.md` §11).

Legend — Backend: `supabase-auth` (client SDK), `supabase-db` (RLS-protected direct), `fastapi` (business logic via API), `local` (device only).

## Planned standard screens (stack-level)

| Screen (ref) | Purpose | Key actions | Action → backend mapping | Status |
| --- | --- | --- | --- | --- |
| Welcome / onboarding | Explain value; entry choice | Continue as guest → `signInAnonymously()` → supabase-auth; Continue with Google → OAuth → supabase-auth; Continue with Apple → OAuth (nonce) → supabase-auth | planned |
| Home | Main surface after entry | Navigation, primary content | fastapi / supabase-db (depends on feature) | planned |
| Settings | Account management | Link account (F-004) → supabase-auth; Sign out (F-007) → supabase-auth; Delete account (F-009) → fastapi + supabase-auth | planned |
| Profile | User identity | View/edit profile → supabase-db (RLS) via fastapi where validation is needed | planned |

Every implemented screen must appear here with a `REFERENCE_SCREENS/` file reference once screenshots are supplied.

## App-specific screens

| Screen (ref) | Purpose | Key actions | Action → backend mapping | Status |
| --- | --- | --- | --- | --- |
| — | *Awaiting `reference_material/REFERENCE_SCREENS/`* | — | — | — |

## States required on every screen

Empty · Loading · Error · Success · Disabled · Offline — see `skills/reference-screen-implementation/SKILL.md`.
