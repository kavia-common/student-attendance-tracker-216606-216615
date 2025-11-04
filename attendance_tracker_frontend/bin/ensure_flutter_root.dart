import 'dart:io';

/// PUBLIC_INTERFACE
/// A utility to ensure commands are run from the Flutter project root.
/// This script checks for the presence of pubspec.yaml in the current
/// working directory and prints guidance if it's missing.
///
/// Usage (in CI or locally):
///   dart run bin/ensure_flutter_root.dart
/// If it fails, set working directory to:
///   student-attendance-tracker-216606-216615/attendance_tracker_frontend
void main(List<String> args) {
  final file = File('pubspec.yaml');
  if (!file.existsSync()) {
    stderr.writeln('Error: pubspec.yaml not found in current directory.');
    stderr.writeln('Please set working directory to:');
    stderr.writeln('student-attendance-tracker-216606-216615/attendance_tracker_frontend');
    // Non-zero exit helps CI detect misconfigured working directory.
    exit(2);
  }
  stdout.writeln('Flutter project root verified at: ${Directory.current.path}');
}
