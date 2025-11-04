#!/usr/bin/env bash
# PUBLIC_INTERFACE
# Prints the absolute path to the Flutter project root and exits 0 if found.
# Usage in CI:
#   FLUTTER_DIR="$(bash student-attendance-tracker-216606-216615/ensure_flutter_root.sh)"
#   cd "$FLUTTER_DIR"
#   flutter pub get && flutter analyze && CI=true flutter test -r expanded

set -euo pipefail

ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
FLUTTER_DIR="$ROOT/attendance_tracker_frontend"

if [[ -f "$FLUTTER_DIR/pubspec.yaml" && -f "$FLUTTER_DIR/lib/main.dart" ]]; then
  echo "$FLUTTER_DIR"
  exit 0
fi

echo "Error: Could not determine Flutter project root at: $FLUTTER_DIR" >&2
echo "Tip: Run helper script: bash student-attendance-tracker-216606-216615/print_flutter_project_root.sh" >&2
exit 2
