import 'package:flutter_test/flutter_test.dart';
import 'package:amr/main.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

void main() {
  testWidgets('Home page smoke test', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(
      const ProviderScope(
        child: BedayaApp(),
      ),
    );

    // Verify that the title exists.
    expect(find.text('بداية'), findsAtLeast(1));
  });
}
