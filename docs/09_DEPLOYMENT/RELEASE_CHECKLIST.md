# RELEASE_CHECKLIST

Final submission requirements — Apple App Store and Google Play. Verify start-to-finish before any store submission; keep evidence (command outputs, screenshots, policy URLs with check dates) in the release record.

## Code & infrastructure

- [ ] `flutter analyze` clean; `dart format` clean; `flutter test` green
- [ ] `pytest` green (unit + integration + contract)
- [ ] Supabase migrations apply cleanly to a fresh database; RLS tests green
- [ ] All CI workflows green on the release commit
- [ ] `PROJECT_STATE.md`, `CHANGELOG.md`, and affected docs current
- [ ] Backend deployed and reachable; production environment variables verified (no dev/test URLs)

## Security

- [ ] `security-code-review` skill checklist completed; findings resolved or accepted in `SECURITY_OVERVIEW.md`
- [ ] No secrets in the client build (scan the built artifact for keys)
- [ ] JWT verification proven against forged/expired/wrong-audience tokens
- [ ] Rate limiting active on sensitive endpoints
- [ ] Production Supabase project has: CAPTCHA for anonymous sign-ins, correct redirect allow-list, RLS on all tables

## Compliance (from STORE_COMPLIANCE.md — re-verify URLs & dates)

- [ ] Account deletion works end-to-end (in-app + external page; Apple token revocation; Play Console deletion URL registered)
- [ ] Sign in with Apple present on iOS (Guideline 4.8)
- [ ] Data safety declaration (Google) and privacy labels (Apple) match `DATA_INVENTORY.md`
- [ ] Privacy policy live and linked in-app + in both store listings
- [ ] Age rating / target-audience answers consistent with app content
- [ ] Policy-area audit done against the app's actual features (payments, UGC, permissions, children, IP rights…)
- [ ] Store metadata (descriptions, screenshots, demo account) prepared

## Review access

- [ ] Apple: working backend + demo account credentials for the review team; no broken or inaccessible account features
- [ ] Google: closed test requirement satisfied if applicable (personal accounts created after 2023-11-13: ≥12 testers, 14 days) — owner confirmed account type
- [ ] Signing: Android keystore + Play App Signing; iOS certificates/provisioning (Part 3)

## Monitoring & rollback

- [ ] Crash monitoring active (Sentry or decided alternative) and verified receiving events
- [ ] Rollback plan: previous backend version deployable; store rollback procedure known
