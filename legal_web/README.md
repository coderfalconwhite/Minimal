# legal_web — Public Legal Pages

Static, deployable pages required by the app stores. These must stay in sync with `docs/07_PRIVACY_COMPLIANCE/DATA_INVENTORY.md` — a mismatch between the pages and actual data handling is a store-rejection and trust risk.

| Folder | Page | Store requirement |
| --- | --- | --- |
| `privacy-policy/` | Privacy policy (collection, use, third-party sharing, retention, deletion) | Apple: accessible, explains all five areas · Google: linked in-app + Play listing |
| `terms/` | Terms of service | Standard requirement for account-based apps |
| `account-deletion/` | External account-deletion page | Google Play: web deletion path, URL registered in Play Console |

## authoring notes

- One self-contained `index.html` per folder (no build step, responsive, `<meta name="viewport">` set).
- Fill from `DATA_INVENTORY.md` when the app plan arrives; never copy a generic template with blanks.
- Publish URLs must be registered in Play Console / App Store Connect and linked from the app (Settings screen).
- Last-reviewed date visible on each page; re-review before each store submission.
