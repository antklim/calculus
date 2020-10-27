import 'package:calculus/app.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets('Calculus smoke test', (WidgetTester tester) async {
    await tester.pumpWidget(Calculus());
    expect(find.text('Calculus'), findsOneWidget);
  });
}
