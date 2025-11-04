#!/usr/bin/env bash
# PUBLIC_INTERFACE
# Echo the absolute path to the Flutter project root.
# Exit 0 if found, 2 otherwise.
# Usage:
#   FLUTTER_DIR="$(bash student-attendance-tracker-216606-216615/echo_flutter_root.sh)"
#   cd "$FLUTTER_DIR"

set -euo pipefail

ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
FLUTTER_DIR="$ROOT/attendance_tracker_frontend"

if [[ -f "$FLUTTER_DIR/pubspec.yaml" && -f "$FLUTTER_DIR/lib/main.dart" ]]; then
  echo "$FLUTTER_DIR"
  exit 0
fi

echo "Could not determine project root directory for Flutter project" >&2
echo "Expected at: $FLUTTER_DIR" >&2
exit 2
