# REFERENCE_INDEX.md — Master Index of Reference Material

> `reference_material/` is the **product-design source** for this project. It is not disposable. The agent treats every file here as the authority on what the app should do and look like, and never redesigns arbitrarily (see `AGENTS.md` §3).

## How to add material

| Folder | What goes here | Status |
| --- | --- | --- |
| `APP_PLAN/` | The app idea and plan documents (problem, objectives, target users, features, constraints) | ⬜ Awaiting product owner |
| `REFERENCE_SCREENS/` | App screenshots — one image (or set) per screen, named descriptively | ⬜ Awaiting product owner |
| `USER_FLOWS/` | User journey descriptions / flow diagrams | ⬜ Awaiting product owner |
| `DESIGN_ASSETS/` | Logos, brand colors, fonts, icons | ⬜ Awaiting product owner |
| `FEATURE_REQUIREMENTS/` | Per-feature requirement documents | ⬜ Awaiting product owner |

Suggested naming for screenshots: `NN_short-screen-name.png` (e.g. `01_welcome.png`, `02_login.png`, `03_home.png`). Any format is accepted (PNG/JPG/PDF).

## What the agent does once material arrives

1. Read every document in `APP_PLAN/` and `FEATURE_REQUIREMENTS/`.
2. Analyze every screenshot in `REFERENCE_SCREENS/` following the mandatory procedure in `AGENTS.md` §3 (purpose → layout/components/spacing/typography/colors/navigation → interactions → empty/loading/error/success/disabled states → compare with requirements → improve where justified → implement → connect to real logic → test sizes → update mapping).
3. Write the analysis into the fixed documentation set under `docs/` (screen inventory, API mapping, database plan, permission matrix, feature backlog).
4. Produce `docs/02_FRONTEND/UI_IMPROVEMENT_PROPOSALS.md` and **ask the product owner**: build the improved UI/UX, or the faithful default one?
5. Only after that decision, start building.

## Register of analyzed material

| Date | File | Analyzed by | Output documents |
| --- | --- | --- | --- |
| — | — | — | — |
