import 'dart:io';

/// PUBLIC_INTERFACE
/// Verifies and prints the Flutter project root path for CI.
/// Exit 0 on success; exit 2 if not found.
void main() {
  final workspace = Directory.current;
  // Expected relative path for the flutter app
  final flutterRoot = Directory(
      '${workspace.path}/student-attendance-tracker-216606-216615/attendance_tracker_frontend');

  final ok = File('${flutterRoot.path}/pubspec.yaml').existsSync() &&
      File('${flutterRoot.path}/lib/main.dart').existsSync() &&
      Directory('${flutterRoot.path}/android').existsSync();

  if (ok) {
    stdout.writeln(flutterRoot.path);
    exit(0);
  }

  // Fallback: if already in the Flutter dir
  final hereOk = File('pubspec.yaml').existsSync() &&
      File('lib/main.dart').existsSync() &&
      Directory('android').existsSync();
  if (hereOk) {
    stdout.writeln(Directory.current.path);
    exit(0);
  }

  stderr.writeln('Could not determine project root directory for Flutter project');
  stderr.writeln('Expected at: ${flutterRoot.path}');
  exit(2);
}
