import 'package:flutter_test/flutter_test.dart';
import 'package:attendance_tracker_frontend/app_root.dart';

void main() {
  testWidgets('App builds and shows Login screen initially', (tester) async {
    await tester.pumpWidget(const AppRoot());
    expect(find.text('Login'), findsOneWidget);
  });

  testWidgets('Navigation from Login to Dashboard works and shows Quick Actions', (tester) async {
    await tester.pumpWidget(const AppRoot());
    final proceedButton = find.text('Proceed to Dashboard');
    expect(proceedButton, findsOneWidget);

    await tester.tap(proceedButton);
    await tester.pumpAndSettle();

    expect(find.text('Dashboard'), findsOneWidget);
    expect(find.text('Quick Actions'), findsOneWidget);
  });
}
