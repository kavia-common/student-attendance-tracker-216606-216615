# CI Usage - Workspace with Flutter + Node API

To avoid: "Could not determine project root directory for Flutter project"

Use one of the provided helpers to detect and set the Flutter project root before running Flutter commands:

Option A - Shell helper (recommended):
  FLUTTER_DIR="$(bash student-attendance-tracker-216606-216615/print_flutter_project_root.sh)"
  cd "$FLUTTER_DIR"
  flutter pub get
  flutter analyze
  CI=true flutter test -r expanded

Option B - Makefile convenience targets:
  make -C student-attendance-tracker-216606-216615 flutter-get
  make -C student-attendance-tracker-216606-216615 flutter-analyze
  make -C student-attendance-tracker-216606-216615 flutter-test

Option C - Dart helper:
  dart run student-attendance-tracker-216606-216615/attendance_tracker_frontend/bin/ensure_flutter_root.dart

Notes:
- The Flutter project root is: student-attendance-tracker-216606-216615/attendance_tracker_frontend
- Do NOT run Flutter commands from the repository root.
- Backend changes do not affect Flutter; ensure CI steps cd into the Flutter project before running Flutter jobs.
