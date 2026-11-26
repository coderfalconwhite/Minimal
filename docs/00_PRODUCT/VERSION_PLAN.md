# VERSION_PLAN

Proposed release mapping for features. Updated whenever a feature is added or its status changes.

## v0.1.0 — Foundation (Part 1)

Goal: verified skeleton with auth, CI, and security baseline.

- F-011 FastAPI JWT verification (JWKS)
- F-001 Guest authentication
- F-005 User profile creation
- F-006 Session persistence
- F-007 Sign-out
- F-008 Auth error handling
- F-012 RLS baseline (profiles table)
- CI: formatting, analysis, unit tests, migration checks
- Documentation set complete and current

## v0.2.0 — Authentication complete

- F-002 Google sign-in
- F-003 Apple sign-in (config needs Apple developer account)
- F-004 Guest → account linking (conflict handling, merge rules)
- F-009 Account deletion workflow (in-app + external web page)
- F-010 Guest data reset/deletion
- Authorization + RLS tests green

## v0.3.0+ — Application releases (planned after app plan arrives)

Features from `FEATURE_BACKLOG.md` are assigned here once the app plan and reference screens are analyzed.

| Release | Theme | Features |
| --- | --- | --- |
| v0.3.0 | Core app screens | TBD from `reference_material/` |
| v0.4.0 | Secondary features | TBD |
| v0.5.0 | Polish: offline, accessibility, responsive | TBD |
| v1.0.0 | Store submission candidate | TBD + release checklist |

## Notes

- Version numbers are proposals; they shift as the plan firms up.
- Monetization: free at launch, no paid features — payment architecture review only becomes relevant if that changes.
