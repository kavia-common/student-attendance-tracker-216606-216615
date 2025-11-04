Flutter project root for this workspace

Path:
student-attendance-tracker-216606-216615/attendance_tracker_frontend

CI quick start:
- Bootstrap and run all checks:
  bash student-attendance-tracker-216606-216615/ci_bootstrap_flutter.sh all

- Or manually:
  FLUTTER_DIR="$(bash student-attendance-tracker-216606-216615/print_flutter_project_root.sh)"
  cd "$FLUTTER_DIR"
  flutter pub get && flutter analyze && CI=true flutter test -r expanded
