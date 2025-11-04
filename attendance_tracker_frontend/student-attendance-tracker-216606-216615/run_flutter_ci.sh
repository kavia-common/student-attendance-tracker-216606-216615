#!/usr/bin/env bash
# PUBLIC_INTERFACE
# Run Flutter CI commands from the correct project root.
# Usage:
#   ./student-attendance-tracker-216606-216615/run_flutter_ci.sh get|analyze|test|all

set -euo pipefail

ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
FLUTTER_DIR="$ROOT/attendance_tracker_frontend"

if [[ ! -f "$FLUTTER_DIR/pubspec.yaml" || ! -f "$FLUTTER_DIR/lib/main.dart" ]]; then
  echo "Could not determine project root directory for Flutter project" >&2
  echo "Expected at: $FLUTTER_DIR" >&2
  exit 2
fi

CMD="${1:-all}"
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
  all)
    (cd "$FLUTTER_DIR" && flutter pub get && flutter analyze && CI=true flutter test -r expanded)
    ;;
  *)
    echo "Usage: $0 {get|analyze|test|all}" >&2
    exit 1
    ;;
esac
