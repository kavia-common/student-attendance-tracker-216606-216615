import 'dart:io';

/// PUBLIC_INTERFACE
/// Verifies this directory is the Flutter project root by checking pubspec.yaml
/// and common Flutter artifacts. Exits 0 on success so CI/root detection can
/// rely on it.
void main() {
  final here = Directory.current;
  final hasPubspec = File('pubspec.yaml').existsSync();
  final hasLibMain = File('lib/main.dart').existsSync();
  final hasAndroid = Directory('android').existsSync();
  final hasAnalysis = File('analysis_options.yaml').existsSync();

  if (hasPubspec && hasLibMain && hasAndroid && hasAnalysis) {
    stdout.writeln('Flutter project root verified at: ${here.path}');
    exit(0);
  } else {
    stderr.writeln('Not at Flutter project root. Ensure working directory is: '
        'student-attendance-tracker-216606-216615/attendance_tracker_frontend');
    exit(2);
  }
}
