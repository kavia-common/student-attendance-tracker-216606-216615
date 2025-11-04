import 'dart:io';

/// PUBLIC_INTERFACE
/// Prints the current directory if this is the Flutter project root
/// by verifying presence of pubspec.yaml.
/// Exit code 0 indicates success; non-zero indicates not at root.
void main() {
  final pubspec = File('pubspec.yaml');
  if (pubspec.existsSync()) {
    stdout.writeln(Directory.current.path);
    exit(0);
  } else {
    stderr.writeln('Not in Flutter project root. Expected pubspec.yaml.');
    exit(2);
  }
}
