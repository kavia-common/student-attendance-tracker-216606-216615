import 'dart:io';

/// PUBLIC_INTERFACE
/// Prints the absolute path of the Flutter project root if current directory
/// is correct. Exits non-zero otherwise.
void main() {
  final here = Directory.current;
  final ok = File('pubspec.yaml').existsSync() &&
      File('lib/main.dart').existsSync() &&
      Directory('android').existsSync();

  if (ok) {
    stdout.writeln(here.absolute.path);
    exit(0);
  } else {
    stderr.writeln('Not at Flutter root. Expected pubspec.yaml and lib/main.dart here.');
    exit(2);
  }
}
