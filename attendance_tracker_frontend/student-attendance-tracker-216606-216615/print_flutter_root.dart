import 'dart:io';

/// PUBLIC_INTERFACE
/// Prints the absolute path to the Flutter project root and exits 0.
/// Exits 2 if not found.
/// Intended for CI systems that execute from the repository root.
///
/// Usage:
///   dart run student-attendance-tracker-216606-216615/print_flutter_root.dart
void main() {
  final repoRoot = Directory.current;
  final flutterRoot = Directory(
    '${repoRoot.path}/student-attendance-tracker-216606-216615/attendance_tracker_frontend',
  );
  final ok = File('${flutterRoot.path}/pubspec.yaml').existsSync() &&
      File('${flutterRoot.path}/lib/main.dart').existsSync();
  if (ok) {
    stdout.writeln(flutterRoot.path);
    exit(0);
  }
  stderr.writeln('Could not determine Flutter project root directory for Flutter project.');
  stderr.writeln('Expected at: ${flutterRoot.path}');
  exit(2);
}
