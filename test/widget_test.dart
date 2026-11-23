import 'package:flutter_test/flutter_test.dart';
import 'package:viva/main.dart';

void main() {
  testWidgets('Listener profile page loads correctly', (WidgetTester tester) async {
    await tester.pumpWidget(const VivaApp());
    await tester.pumpAndSettle();

    expect(find.text('Profile'), findsNWidgets(2));
    expect(find.text('Anushka'), findsOneWidget);
  });
}
