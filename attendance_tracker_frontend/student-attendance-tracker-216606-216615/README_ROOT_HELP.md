Root detection for Flutter project

If CI reports:
  "Could not determine project root directory for Flutter project"

Use one of these from the repository root:
- bash student-attendance-tracker-216606-216615/print_flutter_project_root.sh
- bash student-attendance-tracker-216606-216615/echo_flutter_root.sh
- bash student-attendance-tracker-216606-216615/ensure_flutter_root.sh
- dart run student-attendance-tracker-216606-216615/print_flutter_root.dart

Then cd to the printed directory before running:
- flutter pub get
- flutter analyze
- CI=true flutter test -r expanded
