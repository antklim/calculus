import 'package:calculus/calculus/use_case.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('Calculator use case', () {
    group('calculates value of', () {
      Map<CalculatorUseCase, num> testCases = {
        CalculatorUseCase(
            operation: Operation.addition, operandA: 1, operandB: 2): 3,
        CalculatorUseCase(
            operation: Operation.subtraction, operandA: 1, operandB: 2): -1,
        CalculatorUseCase(
            operation: Operation.multiplication, operandA: 1, operandB: 2): 2,
        CalculatorUseCase(
            operation: Operation.division, operandA: 1, operandB: 2): 0.5,
        CalculatorUseCase(operation: Operation.sqrt, operandA: 1, operandB: 2):
            1,
      };
      testCases.forEach((useCase, expected) {
        test('${useCase.operation}', () {
          expect(useCase.value, expected);
        });
      });
    });

    group('formats', () {
      Map<CalculatorUseCase, String> testCases = {
        CalculatorUseCase(
            operation: Operation.addition, operandA: 1, operandB: 2): '1 + 2',
        CalculatorUseCase(
            operation: Operation.subtraction,
            operandA: 1,
            operandB: 2): '1 - 2',
        CalculatorUseCase(
            operation: Operation.multiplication,
            operandA: 1,
            operandB: 2): '1 * 2',
        CalculatorUseCase(
            operation: Operation.division, operandA: 1, operandB: 2): '1 / 2',
        CalculatorUseCase(operation: Operation.sqrt, operandA: 1, operandB: 2):
            'sqrt(1)',
      };
      testCases.forEach((useCase, expected) {
        test('${useCase.operation}', () {
          expect(useCase.format, expected);
        });
      });
    });
  });
}
