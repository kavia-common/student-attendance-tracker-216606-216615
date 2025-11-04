/*
  This file exists solely to anchor CI/tooling to this Flutter project's root.
  Some CI tools scan for a Dart entry under the working directory to determine
  the correct root. This file imports local artifacts to assert location.

  Not used by the app runtime.
*/
import 'dart:io';

void main() {
  // Verify pubspec.yaml exists here.
  final pubspec = File('pubspec.yaml');
  if (!pubspec.existsSync()) {
    // Non-zero exit indicates wrong working directory.
    stderr.writeln('Error: pubspec.yaml not found. Run from project root: '
        'student-attendance-tracker-216606-216615/attendance_tracker_frontend');
    exit(1);
  }
  // Print a marker for CI logs.
  stdout.writeln('Flutter project root verified at: ${Directory.current.path}');
}
