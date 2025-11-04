#!/usr/bin/env bash
# PUBLIC_INTERFACE
# Prints and verifies the Flutter project root for CI.

set -euo pipefail

ROOT="$(pwd)/student-attendance-tracker-216606-216615/attendance_tracker_frontend"
if [[ -f "$ROOT/pubspec.yaml" && -f "$ROOT/lib/main.dart" && -d "$ROOT/android" ]]; then
  echo "$ROOT"
  exit 0
fi

# Fallback if script is run from inside the Flutter directory
if [[ -f "pubspec.yaml" && -f "lib/main.dart" && -d "android" ]]; then
  pwd
  exit 0
fi

echo "Could not verify Flutter root at: $ROOT" >&2
exit 2
