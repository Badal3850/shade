import 'package:flutter_test/flutter_test.dart';
import 'package:digital_pet/app.dart';

void main() {
  testWidgets('App launches successfully', (WidgetTester tester) async {
    await tester.pumpWidget(const DigitalPetApp());
    expect(find.text('Digital Pet'), findsOneWidget);
  });
}
