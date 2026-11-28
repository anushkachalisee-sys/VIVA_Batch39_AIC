import 'package:flutter_test/flutter_test.dart';
import 'package:viva/main.dart';

void main() {
  testWidgets('Artist Profile Creation screen smoke test', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(const VivaApp());

    // Verify that Artist Profile Creation screen elements are present.
    expect(find.text('Create Artist Profile'), findsOneWidget);
    expect(find.text('Artist Name *'), findsOneWidget);
    expect(find.text('Choose Your Music Genres *'), findsOneWidget);
    expect(find.text('Create Profile'), findsOneWidget);
  });
}
