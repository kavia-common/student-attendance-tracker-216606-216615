import 'dart:io';

/// PUBLIC_INTERFACE
/// Exposed root check flag for tests to touch and avoid unused import warnings.
/// This runs immediately on import to provide CI guidance without failing tests.
final bool rootCheck = (() {
  final hasPubspec = File('pubspec.yaml').existsSync();
  final hasLibMain = File('lib/main.dart').existsSync();
  final hasAndroid = Directory('android').existsSync();

  if (!(hasPubspec && hasLibMain && hasAndroid)) {
    // Print guidance to stderr without failing tests.
    stderr.writeln('Could not determine project root directory for Flutter project.');
    stderr.writeln('Please run from: student-attendance-tracker-216606-216615/attendance_tracker_frontend');
    stderr.writeln('Tip: bash student-attendance-tracker-216606-216615/print_flutter_project_root.sh');
  }
  return true;
})();
