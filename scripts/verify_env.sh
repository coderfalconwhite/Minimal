#!/usr/bin/env bash
# verify_env.sh — Part 1 foundation check: Git and environment verification.
# Verifies the toolchain exists and prints versions. Non-zero exit on missing
# required tool. Native mobile tooling (Android SDK/NDK, Xcode) is explicitly
# EXCLUDED (deferred to Part 3 per the project plan).
set -euo pipefail

MISSING=0

check() { # name, command, required?
  local name="$1" cmd="$2" required="${3:-required}"
  if command -v "$cmd" >/dev/null 2>&1; then
    printf "  [ok]   %-14s %s\n" "$name" "$($cmd --version 2>&1 | head -1)"
  else
    if [ "$required" = "required" ]; then
      printf "  [MISS] %-14s not found (required)\n" "$name"; MISSING=1
    else
      printf "  [opt]  %-14s not found (optional, Part 3)\n" "$name"
    fi
  fi
}

echo "== MY_APPLICATION environment verification =="
check git git
check flutter flutter
check dart dart
check python python3
check uv uv optional
check pytest pytest optional
check supabase supabase optional
check node node optional

if [ "$MISSING" -ne 0 ]; then
  echo "RESULT: FAIL — required tools missing (see above)."
  exit 1
fi
echo "RESULT: OK — required environment present."
