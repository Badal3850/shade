import 'package:flutter_test/flutter_test.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shade/app.dart';
import 'package:shade/core/di/injection_container.dart';

void main() {
  testWidgets('App launches successfully', (WidgetTester tester) async {
    SharedPreferences.setMockInitialValues({});
    await configureDependencies();

    await tester.pumpWidget(const ShadeApp());
    await tester.pump();

    expect(find.text('name your\nshade.'), findsOneWidget);
  });
}
