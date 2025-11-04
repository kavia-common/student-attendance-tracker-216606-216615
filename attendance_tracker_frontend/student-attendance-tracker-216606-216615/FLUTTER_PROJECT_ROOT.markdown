This workspace contains a Flutter application.

Flutter project root:
student-attendance-tracker-216606-216615/attendance_tracker_frontend

CI usage:
- Determine and cd into the Flutter project root before running any Flutter commands.
- Helper script to echo absolute path:
  bash student-attendance-tracker-216606-216615/print_flutter_project_root.sh
- Or use:
  FLUTTER_DIR="$(bash student-attendance-tracker-216606-216615/ensure_flutter_root.sh)"
  cd "$FLUTTER_DIR"
  flutter pub get && flutter analyze && CI=true flutter test -r expanded
