# AUTH_FLOW

Guest, Google, and Apple authentication — the single authoritative description.

## Identity model

- **Guest (primary)**: Supabase Anonymous Authentication (`signInAnonymously()`). A real `auth.users` row with a session; RLS applies normally. Not a recoverable account.
- **Registered (optional)**: Google or Apple OAuth via Supabase's supported native flows.
- **Linking**: a guest can attach Google/Apple identity to their existing anonymous identity (Supabase identity linking, manual linking mode enabled in project config).

## Primary flow

```
User opens app
  → Welcome: "Continue as guest"  OR  "Continue with Google"  OR  "Continue with Apple"
  → Supabase Auth verifies identity and establishes the user session
  → Flutter stores the session persistently (secure storage)
  → Every FastAPI request: Authorization: Bearer <supabase access token>
  → FastAPI verifies token via JWKS (signature, issuer, audience, expiry)
  → Authorized access to application features
```

## Guest specifics

1. User selects *Continue as guest* → Flutter calls `signInAnonymously()`.
2. Supabase creates an anonymous user identity with an authenticated session.
3. The app uses that user ID for the user's permitted data (profiles, app data — RLS).
4. Later, in Settings, the user may link Google/Apple to the same identity.

**Limitations that must be surfaced to users**: signing out, clearing app data, or moving devices without linking loses access to the anonymous account. The app shows a clear explanation and offers account linking.

**Abuse protection**: CAPTCHA enabled for anonymous sign-ins (Supabase recommendation); retention/cleanup policy for anonymous accounts (Supabase does not remove them automatically).

## Account linking rules

- Linking is offered in Settings; never forced.
- If the Google/Apple identity **already belongs to another account**, the app surfaces the conflict and asks the user how to proceed. **Never silently transfer or overwrite guest data.**
- Data migration/merge rules are explicit, documented, and reversible until confirmed.
- On success: `profiles.is_anonymous = false`, `linked_at = now()`.

## Apple specifics

- Sign in with Apple is **required on iOS** because Google login is offered (Apple Guideline 4.8 equivalent-login rule).
- Uses nonce handling per Supabase's supported flow; provider configuration requires the app's registered identifiers (bundle/services IDs, team).
- On account deletion, associated tokens are revoked as Apple requires.

## Session handling

- Login persistence and session restoration on app start.
- Token refresh handled by supabase_flutter.
- Expired/invalid session → graceful re-authentication path, never a dead end.
- Sign-out clears local session data.

## Deletion (see PRIVACY_AND_DELETION.md for the full procedure)

In-app initiation (both stores require it) → FastAPI orchestrates: app data, storage files, third-party tokens, Supabase Auth user. External web deletion page for Google Play: `legal_web/account-deletion/`.

## Open configuration requirements

- Supabase project: anonymous auth enabled, Google provider, Apple provider, manual linking enabled, CAPTCHA for anonymous sign-ins.
- OAuth app registrations (Google console, Apple developer account) — credentials server-side only.
