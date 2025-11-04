import 'dart:io';

/// PUBLIC_INTERFACE
/// Prints the absolute path of the Flutter project root. Exit 0 on success.
/// Usage:
///   dart run student-attendance-tracker-216606-216615/attendance_tracker_frontend/tool/echo_project_root.dart
void main() {
  // If run from the app root, just print current dir.
  if (File('pubspec.yaml').existsSync() && File('lib/main.dart').existsSync()) {
    stdout.writeln(Directory.current.absolute.path);
    exit(0);
  }

  // Try to resolve relative to known workspace path.
  final here = Directory.current;
  final cand = Directory('${here.path}/student-attendance-tracker-216606-216615/attendance_tracker_frontend');
  if (File('${cand.path}/pubspec.yaml').existsSync() &&
      File('${cand.path}/lib/main.dart').existsSync()) {
    stdout.writeln(cand.absolute.path);
    exit(0);
  }

  // Try walking up directories a few levels to locate the marker
  Directory dir = here;
  for (int i = 0; i < 5; i++) {
    final maybe = Directory('${dir.path}/student-attendance-tracker-216606-216615/attendance_tracker_frontend');
    if (File('${maybe.path}/pubspec.yaml').existsSync() &&
        File('${maybe.path}/lib/main.dart').existsSync()) {
      stdout.writeln(maybe.absolute.path);
      exit(0);
    }
    final parent = dir.parent;
    if (parent.path == dir.path) break;
    dir = parent;
  }

  stderr.writeln('Failed to locate Flutter project root. '
      'Expected at student-attendance-tracker-216606-216615/attendance_tracker_frontend');
  exit(2);
}
