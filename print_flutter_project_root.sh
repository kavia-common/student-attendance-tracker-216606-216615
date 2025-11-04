#!/usr/bin/env bash
# PUBLIC_INTERFACE
# Prints the absolute path to the Flutter project root to aid CI/tools that
# cannot auto-detect the project root. Exits 0 on success, non-zero on failure.

set -euo pipefail

ROOT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
FLUTTER_DIR="$ROOT_DIR/attendance_tracker_frontend"

if [[ -f "$FLUTTER_DIR/pubspec.yaml" && -f "$FLUTTER_DIR/lib/main.dart" ]]; then
  echo "$FLUTTER_DIR"
  exit 0
fi

echo "Could not determine Flutter project root. Expected at: $FLUTTER_DIR" >&2
exit 2
