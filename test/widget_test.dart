import 'package:flutter_test/flutter_test.dart';

import 'package:hydration_tracker/main.dart';

void main() {
  testWidgets('Hydration tracker smoke test', (WidgetTester tester) async {
    await tester.pumpWidget(const HydrationTrackerApp());

    expect(find.text('Hydration Tracker'), findsOneWidget);
    expect(find.text('Daily Goal'), findsOneWidget);
  });
}
