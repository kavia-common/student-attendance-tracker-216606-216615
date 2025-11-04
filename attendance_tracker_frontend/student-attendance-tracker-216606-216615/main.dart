import 'dart:io';

/// PUBLIC_INTERFACE
/// Workspace shim for CI tools that search for a Dart entrypoint.
/// This is NOT the Flutter app. The real Flutter app entry is:
///   student-attendance-tracker-216606-216615/attendance_tracker_frontend/lib/main.dart
/// This file prints guidance and exits with non-zero to prevent accidental execution.
Future<void> main() async {
  stderr.writeln('Workspace shim: set working directory to: '
      'student-attendance-tracker-216606-216615/attendance_tracker_frontend');
  exit(2);
}
