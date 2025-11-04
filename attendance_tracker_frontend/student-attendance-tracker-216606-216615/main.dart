/// Bootstrap file to help CI/tooling locate the Flutter project root.
/// Delegates to the real Flutter app entrypoint.
import 'attendance_tracker_frontend/main.dart' as app;

Future<void> main() async {
  await app.main();
}
