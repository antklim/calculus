import 'package:calculus/app.dart';
import 'package:calculus/calculus/calculus.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:provider/provider.dart';

void main() {
  group('Calculus screen', () {
    testWidgets('has header', (WidgetTester tester) async {
      await tester.pumpWidget(Calculus());
      expect(find.text('Calculus'), findsOneWidget);
    });

    testWidgets('has two operands', (WidgetTester tester) async {
      await tester.pumpWidget(Calculus());
      expect(find.text('Operand A'), findsOneWidget);
      expect(find.text('Operand B'), findsOneWidget);
    });

    testWidgets('has one operand when operation is SQRT',
        (WidgetTester tester) async {
      // initiate required state
      CalculatorState state = CalculatorState();
      state.setOperation(Sqrt);

      await tester.pumpWidget(MaterialApp(
        home: ChangeNotifierProvider<CalculatorState>(
          create: (_) => state, // passing state to widgtes
          builder: (context, _) => CalculusScreenContainer(),
        ),
      ));
      expect(find.text('Operand A'), findsOneWidget);
      expect(find.text('Operand B'), findsNothing);
    });
  });
}
