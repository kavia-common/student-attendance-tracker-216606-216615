#!/usr/bin/env bash
# PUBLIC_INTERFACE
# Ensures CI sets the correct Flutter project root and prints it.
# Exits 0 and prints path if found, 2 otherwise.
# Usage:
#   FLUTTER_DIR="$(bash student-attendance-tracker-216606-216615/ensure_flutter_root.sh)"
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
exit 2
