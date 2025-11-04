#!/usr/bin/env bash
# PUBLIC_INTERFACE
# Prints the absolute path to the Flutter project root for CI/tools.
# Exits 0 on success; 2 on failure.

set -euo pipefail

ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
FLUTTER_DIR="$ROOT/attendance_tracker_frontend"

if [[ -f "$FLUTTER_DIR/pubspec.yaml" && -f "$FLUTTER_DIR/lib/main.dart" && -d "$FLUTTER_DIR/android" ]]; then
  echo "$FLUTTER_DIR"
  exit 0
fi

echo "Could not determine project root directory for Flutter project" >&2
echo "Expected at: $FLUTTER_DIR" >&2
exit 2
