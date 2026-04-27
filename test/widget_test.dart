import 'package:flutter_test/flutter_test.dart';
import 'package:inventory_p_shalaev/core/core.dart';
import 'package:inventory_p_shalaev/main.dart';

void main() {
  testWidgets('App smoke test', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    // Initialize dependencies
    await ServiceLocator.setup();

    await tester.pumpWidget(const MyApp());

    // Verify that the app title is displayed (you may need to adjust based on exact UI)
    // expect(find.text('Inventory Management'), findsOneWidget);
  });
}
