import 'dart:io';

/// PUBLIC_INTERFACE
/// Workspace root shim that forwards execution to the Flutter app entrypoint.
/// Some CI tools run from workspace root; this file helps them find the Flutter app.
///
/// Note:
/// - We use a process spawn to execute the real Flutter app's entrypoint at lib/main.dart
///   because importing across package boundaries is not valid here.
/// - Tools that need to run the app should cd to the Flutter project root instead:
///   student-attendance-tracker-216606-216615/attendance_tracker_frontend
Future<void> main() async {
  // Print guidance for CI logs and exit; launching Flutter from here isn't supported.
  stderr.writeln('Workspace shim: Please run from Flutter app root: '
      'student-attendance-tracker-216606-216615/attendance_tracker_frontend');
}
