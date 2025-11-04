import 'package:flutter_test/flutter_test.dart';
import 'package:flutter/foundation.dart' show Key;
import 'package:attendance_tracker_frontend/app_root.dart';
// Helps CI print guidance if tests are run from the wrong working directory.
import 'test_root_helper.dart' as test_root_helper;

void main() {
  testWidgets('App builds and shows Login screen initially', (tester) async {
    // Touch helper so import isn't considered unused by analyzer.
    expect(test_root_helper.rootCheck, isTrue);
    await tester.pumpWidget(const AppRoot());
    expect(find.byKey(const Key('login-title')), findsOneWidget);
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
