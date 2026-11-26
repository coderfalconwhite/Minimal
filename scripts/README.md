# scripts/ — Helper scripts

| Script | Purpose |
| --- | --- |
| `verify_env.sh` | Part 1 environment verification: checks Git, Flutter, Dart, Python, and optional tooling; prints versions and fails on missing required tools. Run in CI (`supabase-checks.yml` job `env`) and locally on a new machine. |

Conventions: scripts are POSIX-bash, `set -euo pipefail`, no secrets, no environment-specific paths. Add a row here when adding a script.
