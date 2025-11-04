#!/usr/bin/env bash
# PUBLIC_INTERFACE
# Atomically detect the Flutter project root and run a specified step.
# Usage:
#   bash student-attendance-tracker-216606-216615/ci_bootstrap_flutter.sh get|analyze|test|all
# Exits non-zero if the root cannot be determined.

set -euo pipefail

ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
FLUTTER_DIR="$ROOT/attendance_tracker_frontend"

if [[ ! -f "$FLUTTER_DIR/pubspec.yaml" || ! -f "$FLUTTER_DIR/lib/main.dart" || ! -d "$FLUTTER_DIR/android" ]]; then
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

echo "Flutter CI completed step: $CMD"
