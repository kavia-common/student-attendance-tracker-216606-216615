#!/usr/bin/env bash
# PUBLIC_INTERFACE
# Prints the absolute path of the Flutter project root for CI tools.

set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
FLUTTER_DIR="$SCRIPT_DIR/attendance_tracker_frontend"

if [[ -f "$FLUTTER_DIR/pubspec.yaml" && -f "$FLUTTER_DIR/lib/main.dart" ]]; then
  echo "$FLUTTER_DIR"
  exit 0
else
  echo "Flutter root not found at: $FLUTTER_DIR" >&2
  exit 2
fi
