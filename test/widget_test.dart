import 'package:flutter_test/flutter_test.dart';
import 'package:shade/app.dart';

void main() {
  testWidgets('App launches successfully', (WidgetTester tester) async {
    await tester.pumpWidget(const ShadeApp());
    expect(find.text('shade'), findsOneWidget);
  });
}
