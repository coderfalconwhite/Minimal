# DEVICE_CAPABILITY_MATRIX

Which device capabilities / OS permissions the app uses, why, and the user-facing justification. Updated through change control whenever a feature needs a new permission. Store review checks every declared permission against actual use.

| Capability / permission | Used? | Justification (user-facing) | Feature IDs | Status |
| --- | --- | --- | --- | --- |
| Internet (Android) | Yes | App communicates with its backend | all | approved |
| Camera | TBD | — | — | awaiting app plan |
| Microphone | TBD | — | — | awaiting app plan |
| Precise location (GPS) | **No by policy** | Precise location is never requested solely for analytics; coarse/user-selected region only | — | decided |
| Approximate location | TBD | — | — | awaiting app plan |
| Notifications (push) | TBD | — | — | awaiting app plan |
| Photo library access | TBD | — | — | awaiting app plan |
| Bluetooth / NFC | TBD | — | — | awaiting app plan |
| Background processing | TBD | — | — | awaiting app plan |
| Sign in with Apple | Yes (iOS) | Apple Guideline 4.8 equivalent-login requirement when Google login is offered | F-003 | approved |
| Google sign-in | Yes | Optional login method | F-002 | approved |
| Biometrics / Keychain | Planned | Secure local session storage | F-006 | proposed |

Rules:

1. No permission is declared "just in case".
2. Each permission's purpose string must match this matrix.
3. Precise location for analytics is forbidden (`AGENTS.md` §9).
