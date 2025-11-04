import 'dart:io';

/// PUBLIC_INTERFACE
/// Prints the absolute path to the Flutter project root and exits 0.
/// Intended for CI/tools to discover and cd into the correct directory.
void main() {
  final workspace = Directory.current;
  // Expected relative path for the flutter app
  final flutterRoot = Directory(
      '${workspace.path}/student-attendance-tracker-216606-216615/attendance_tracker_frontend');

  final ok = File('${flutterRoot.path}/pubspec.yaml').existsSync() &&
      File('${flutterRoot.path}/lib/main.dart').existsSync();

  if (ok) {
    stdout.writeln(flutterRoot.path);
    exit(0);
  }

  // Fallback: if we're already in the Flutter dir
  final hereOk = File('pubspec.yaml').existsSync() &&
      File('lib/main.dart').existsSync();
  if (hereOk) {
    stdout.writeln(Directory.current.path);
    exit(0);
  }

  stderr.writeln('Unable to locate Flutter project root automatically. '
      'Expected at student-attendance-tracker-216606-216615/attendance_tracker_frontend');
  exit(2);
}
