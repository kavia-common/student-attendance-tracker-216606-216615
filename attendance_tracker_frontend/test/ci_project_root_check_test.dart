import 'dart:io';
import 'package:flutter_test/flutter_test.dart';

/// This test ensures CI is executing from the Flutter project root directory.
/// It verifies the presence of pubspec.yaml and lib/main.dart. If not found,
/// it fails immediately with guidance on how to set the correct working directory.
/// This improves error messages like:
/// "Could not determine project root directory for Flutter project".
void main() {
  test('CI/project root is correct (pubspec + lib/main.dart present)', () {
    final hasPubspec = File('pubspec.yaml').existsSync();
    final hasLibMain = File('lib/main.dart').existsSync();

    if (!(hasPubspec && hasLibMain)) {
      fail('Could not determine project root directory for Flutter project.\n'
          'Expected to run tests from: student-attendance-tracker-216606-216615/attendance_tracker_frontend\n'
          'Fix:\n'
          '- cd student-attendance-tracker-216606-216615/attendance_tracker_frontend\n'
          '- Or set CI working directory to that path before running flutter test\n'
          '- Helper: bash student-attendance-tracker-216606-216615/print_flutter_project_root.sh');
    }

    // If both files are present, the root is correct.
    expect(hasPubspec, isTrue);
    expect(hasLibMain, isTrue);
  });
}
