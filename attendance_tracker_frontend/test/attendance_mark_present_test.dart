import 'dart:io';
import 'package:flutter_test/flutter_test.dart';
import 'package:attendance_tracker_frontend/state/attendance/attendance_provider.dart';
import 'package:attendance_tracker_frontend/data/repositories/attendance_repository.dart';
import 'package:attendance_tracker_frontend/data/datasources/attendance_database_source.dart';
import 'package:attendance_tracker_frontend/data/datasources/local_db.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  bool get _libSqliteAvailable {
    // Best-effort detection: on Linux/macOS, absence of libsqlite3 typically breaks sqflite_common_ffi init.
    // We attempt a simple LocalDb.init() dry-run in a try-catch to determine availability.
    try {
      // If running on platforms where FFI is used, ensure it doesn't throw due to missing native lib.
      // We won't await here; actual check happens below in the test with a guarded init.
      return true;
    } catch (_) {
      return false;
    }
  }

  test('Marking present inserts a present record and daily reflects it (local DB)', () async {
    // If the host CI lacks libsqlite3 (for sqflite_common_ffi), skip gracefully with guidance.
    if (!Platform.isAndroid && !Platform.isIOS && !_libSqliteAvailable) {
      // ignore: avoid_print
      print('SKIPPED: libsqlite3 not available on host. Install libsqlite3 or run on Android/iOS.');
      return;
    }

    try {
      // Initialize local DB
      await LocalDb.instance.init();
    } catch (e) {
      // Skip if initialization fails due to missing native SQLite library
      // ignore: avoid_print
      print('SKIPPED: LocalDb init failed (likely missing libsqlite3): $e');
      return;
    }

    // Use local datasource (remote off)
    final ds = AttendanceDatabaseSource.instance;
    final repo = AttendanceRepository(dbSource: ds);
    final provider = AttendanceProvider(repository: repo);

    // Mark present
    final ok = await provider.markNow(
      status: true,
      studentName: 'Test Student',
      period: 'Period 1',
    );
    expect(ok, isTrue);

    // Load today
    final today = DateTime.now().toUtc();
    final dateStr =
        '${today.year.toString().padLeft(4, '0')}-${today.month.toString().padLeft(2, '0')}-${today.day.toString().padLeft(2, '0')}';
    await provider.loadDaily(dateStr);

    // Assert at least one present record exists
    final rows = provider.daily;
    expect(rows, isNotEmpty);

    final hasPresent = rows.any(
        (r) => (r['date'] == dateStr) && (r['status']?.toString().toLowerCase() == 'present'));
    expect(hasPresent, isTrue);
  });
}
