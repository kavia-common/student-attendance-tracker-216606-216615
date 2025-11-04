import 'dart:io';

/// PUBLIC_INTERFACE
/// Prints the path to the Flutter project root for CI/tools.
void main() {
  // Relative path to the Flutter app within this workspace.
  final flutterRoot = Directory('attendance_tracker_frontend');
  if (flutterRoot.existsSync() && File('attendance_tracker_frontend/pubspec.yaml').existsSync()) {
    stdout.writeln(flutterRoot.absolute.path);
    exit(0);
  } else {
    stderr.writeln('Flutter root not found at attendance_tracker_frontend');
    exit(2);
  }
}
