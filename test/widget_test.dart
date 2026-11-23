import 'package:flutter_test/flutter_test.dart';
import 'package:viva/main.dart';

void main() {
  testWidgets('App smoke test', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(const VivaApp());

    // Verify that VIVA branding text is present.
    expect(find.text('VIVA'), findsWidgets);
  });

  testWidgets('VIVA Artist Registration screen smoke test', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(const VivaApp());

    // Verify that VIVA header, Bring Your Sound to VIVA title, and CREATE ACCOUNT button exist.
    expect(find.text('VIVA'), findsOneWidget);
    expect(find.text('Bring Your Sound to VIVA'), findsOneWidget);
    expect(find.text('CREATE ACCOUNT'), findsOneWidget);
  });
}
