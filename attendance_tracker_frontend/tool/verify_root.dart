import 'dart:io';

/// PUBLIC_INTERFACE
/// Verifies this is the Flutter project root by checking for pubspec.yaml
/// and prints a success line for CI logs.
void main() {
  final here = Directory.current;
  final hasPubspec = File('pubspec.yaml').existsSync();
  if (hasPubspec) {
    stdout.writeln('Flutter root verified: ${here.path}');
    exit(0);
  } else {
    stderr.writeln('Not at Flutter root. Expected pubspec.yaml in current dir.');
    exit(2);
  }
}
