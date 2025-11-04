import 'dart:io';
import 'package:flutter_test/flutter_test.dart';

/// Prints the current working directory and verifies expected Flutter root markers.
/// This is useful when CI cannot locate the Flutter project root.
/// It does not change app behavior but provides clear diagnostic output.
void main() {
  test('Print working directory and verify Flutter root markers', () {
    final cwd = Directory.current.path;
    // Print to help CI logs
    // ignore: avoid_print
    print('CI Working Directory: $cwd');

    final pubspec = File('pubspec.yaml').existsSync();
    final libMain = File('lib/main.dart').existsSync();
    final androidDir = Directory('android').existsSync();

    // Print markers for visibility even if failing
    // ignore: avoid_print
    print('Markers: pubspec=$pubspec lib/main.dart=$libMain androidDir=$androidDir');

    if (!(pubspec && libMain && androidDir)) {
      fail(
        'Flutter project root markers not found in current directory.\n'
        'Expected to run from: student-attendance-tracker-216606-216615/attendance_tracker_frontend\n'
        'Fix working directory, for example:\n'
        '- bash student-attendance-tracker-216606-216615/print_flutter_project_root.sh (prints absolute path)\n'
        '- cd <printed-path>\n'
        'Then run: flutter pub get && flutter analyze && CI=true flutter test -r expanded',
      );
    }
  });
}
