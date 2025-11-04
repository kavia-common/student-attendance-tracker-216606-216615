# CI Root Help

Use this helper to locate the Flutter project root:

- Flutter app root: student-attendance-tracker-216606-216615/attendance_tracker_frontend

From repository workspace root:

```
bash student-attendance-tracker-216606-216615/print_flutter_project_root.sh
```

The script prints the absolute path to the Flutter project root. Set your CI working directory to that path before running:
- flutter pub get
- flutter analyze
- flutter test
