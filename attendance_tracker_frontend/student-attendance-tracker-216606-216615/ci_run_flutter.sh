#!/usr/bin/env bash
# PUBLIC_INTERFACE
# Runs Flutter commands from the correct project root.
# Usage:
#   ./student-attendance-tracker-216606-216615/ci_run_flutter.sh get|analyze|test

set -euo pipefail

ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
FLUTTER_DIR="$ROOT/attendance_tracker_frontend"

if [[ ! -f "$FLUTTER_DIR/pubspec.yaml" ]]; then
  echo "Flutter project root not found at: $FLUTTER_DIR" >&2
  exit 2
fi

CMD="${1:-}"
case "$CMD" in
  get)
    (cd "$FLUTTER_DIR" && flutter pub get)
    ;;
  analyze)
    (cd "$FLUTTER_DIR" && flutter analyze)
    ;;
  test)
    (cd "$FLUTTER_DIR" && CI=true flutter test -r expanded)
    ;;
  *)
    echo "Usage: $0 {get|analyze|test}" >&2
    exit 1
    ;;
esac
