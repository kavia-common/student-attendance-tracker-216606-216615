import 'package:flutter_test/flutter_test.dart';
import 'package:attendance_tracker_frontend/state/attendance/attendance_provider.dart';
import 'package:attendance_tracker_frontend/data/repositories/attendance_repository.dart';
import 'package:attendance_tracker_frontend/data/datasources/attendance_database_source.dart';
import 'package:attendance_tracker_frontend/data/datasources/local_db.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  test('Marking present inserts a present record and daily reflects it (local DB)', () async {
    // Initialize local DB
    await LocalDb.instance.init();

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
    final dateStr = '${today.year.toString().padLeft(4, '0')}-${today.month.toString().padLeft(2, '0')}-${today.day.toString().padLeft(2, '0')}';
    await provider.loadDaily(dateStr);

    // Assert at least one present record exists
    final rows = provider.daily;
    expect(rows, isNotEmpty);

    final hasPresent = rows.any((r) => (r['date'] == dateStr) && (r['status']?.toString().toLowerCase() == 'present'));
    expect(hasPresent, isTrue);
  });
}
