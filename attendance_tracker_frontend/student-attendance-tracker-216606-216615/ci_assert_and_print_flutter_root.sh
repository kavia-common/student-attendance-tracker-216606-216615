#!/usr/bin/env bash
# PUBLIC_INTERFACE
# Validates and prints the Flutter project root path, then exits 0.
# Exits 2 with guidance if not found.
# Intended for CI pipelines as the very first step before any Flutter commands.
#
# Usage in CI:
#   FLUTTER_DIR="$(bash student-attendance-tracker-216606-216615/ci_assert_and_print_flutter_root.sh)"
#   cd "$FLUTTER_DIR"
#   flutter pub get && flutter analyze && CI=true flutter test -r expanded

set -euo pipefail

ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
FLUTTER_DIR="$ROOT/attendance_tracker_frontend"

if [[ -f "$FLUTTER_DIR/pubspec.yaml" && -f "$FLUTTER_DIR/lib/main.dart" && -d "$FLUTTER_DIR/android" ]]; then
  echo "$FLUTTER_DIR"
  exit 0
fi

echo "Could not determine project root directory for Flutter project" >&2
echo "Expected Flutter project root at: $FLUTTER_DIR" >&2
echo "Fix: cd \"$FLUTTER_DIR\" before running Flutter commands or call:" >&2
echo "     bash student-attendance-tracker-216606-216615/print_flutter_project_root.sh" >&2
exit 2
