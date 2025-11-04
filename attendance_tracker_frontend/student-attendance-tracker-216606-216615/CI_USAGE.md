# CI Usage - Monorepo

To avoid: "Could not determine project root directory for Flutter project"

1) Determine Flutter project root from repo root:
   bash student-attendance-tracker-216606-216615/print_flutter_project_root.sh
   # or
   dart run student-attendance-tracker-216606-216615/print_flutter_root.dart

2) Use Makefile convenience targets (they cd into the app root for you):
   make -C student-attendance-tracker-216606-216615 flutter-get
   make -C student-attendance-tracker-216606-216615 flutter-analyze
   make -C student-attendance-tracker-216606-216615 flutter-test

Alternatively:
   FLUTTER_DIR="$(bash student-attendance-tracker-216606-216615/ensure_flutter_root.sh)"
   cd "$FLUTTER_DIR"
   flutter pub get && flutter analyze && CI=true flutter test -r expanded
