import 'package:flutter_test/flutter_test.dart';
import 'package:attendance_tracker_frontend/app.dart';

void main() {
  testWidgets('MaterialApp builds with Ocean theme and initial route', (tester) async {
    await tester.pumpWidget(const AttendanceApp());
    // Initial route should be login page placeholder text.
    expect(find.text('Login screen placeholder'), findsOneWidget);
  });

  testWidgets('Navigation from Login to Dashboard works', (tester) async {
    await tester.pumpWidget(const AttendanceApp());
    final proceedButton = find.text('Proceed to Dashboard');
    expect(proceedButton, findsOneWidget);

    await tester.tap(proceedButton);
    await tester.pumpAndSettle();

    expect(find.text('Dashboard placeholder'), findsOneWidget);
  });
}
