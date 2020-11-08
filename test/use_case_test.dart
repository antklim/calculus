import 'package:calculus/calculus/operation.dart';
import 'package:calculus/calculus/use_case.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('Calculator use case', () {
    group('calculates value of', () {
      Map<CalculatorUseCase, num> testCases = {
        CalculatorUseCase(operation: Add, operandA: 1, operandB: 2): 3,
        CalculatorUseCase(operation: Sub, operandA: 1, operandB: 2): -1,
        CalculatorUseCase(operation: Mul, operandA: 1, operandB: 2): 2,
        CalculatorUseCase(operation: Div, operandA: 1, operandB: 2): 0.5,
        CalculatorUseCase(operation: Sqrt, operandA: 1, operandB: 2): 1,
      };
      testCases.forEach((useCase, expected) {
        test('${useCase.operation}', () {
          expect(useCase.value, expected);
        });
      });
    });

    group('formats', () {
      Map<CalculatorUseCase, String> testCases = {
        CalculatorUseCase(operation: Add, operandA: 1, operandB: 2): '1 + 2',
        CalculatorUseCase(operation: Sub, operandA: 1, operandB: 2): '1 - 2',
        CalculatorUseCase(operation: Mul, operandA: 1, operandB: 2): '1 * 2',
        CalculatorUseCase(operation: Div, operandA: 1, operandB: 2): '1 / 2',
        CalculatorUseCase(operation: Sqrt, operandA: 1, operandB: 2): 'sqrt(1)',
      };
      testCases.forEach((useCase, expected) {
        test('${useCase.operation}', () {
          expect(useCase.format, expected);
        });
      });
    });

    test('sets operation', () {
      bool memoryChanged = false;
      void onMemoryChanged() => memoryChanged = true;

      bool operationChanged = false;
      void onOperationChanged() => operationChanged = true;

      CalculatorUseCase useCase = CalculatorUseCase(
          operation: Add,
          operandA: 1,
          operandB: 2,
          onMemoryChanged: onMemoryChanged,
          onOperationChanged: onOperationChanged);

      expect(useCase.operation, Add);
      expect(useCase.value, 3);
      useCase.setOperation(Sub);
      expect(useCase.operation, Sub);
      expect(useCase.value, -1);
      expect(memoryChanged, false);
      expect(operationChanged, true);
    });

    test('sets operands', () {
      bool memoryChanged = false;
      void onMemoryChanged() => memoryChanged = true;

      bool operationChanged = false;
      void onOperationChanged() => operationChanged = true;

      CalculatorUseCase useCase = CalculatorUseCase(
          operation: Add,
          operandA: 1,
          operandB: 2,
          onMemoryChanged: onMemoryChanged,
          onOperationChanged: onOperationChanged);

      expect(useCase.operandA, 1);
      expect(useCase.operandB, 2);

      useCase.setOperand(Operand.A)(4);
      expect(useCase.operandA, 4);
      expect(useCase.operandB, 2);

      useCase.setOperand(Operand.B)(6);
      expect(useCase.operandA, 4);
      expect(useCase.operandB, 6);

      expect(memoryChanged, false);
      expect(operationChanged, true);
    });

    test('sets operands from memory', () {
      bool memoryChanged = false;
      void onMemoryChanged() => memoryChanged = true;

      bool operationChanged = false;
      void onOperationChanged() => operationChanged = true;

      CalculatorUseCase useCase = CalculatorUseCase(
          operation: Add,
          operandA: 1,
          operandB: 2,
          onMemoryChanged: onMemoryChanged,
          onOperationChanged: onOperationChanged);

      expect(useCase.operandA, 1);
      expect(useCase.operandB, 2);

      useCase.fromMemory(Operand.A);
      expect(useCase.operandA, 1);
      expect(useCase.operandB, 2);

      expect(memoryChanged, false);
      expect(operationChanged, false);

      useCase.memorise();
      useCase.fromMemory(Operand.A);
      expect(useCase.operandA, 3);
      expect(useCase.operandB, 2);

      useCase.fromMemory(Operand.B);
      expect(useCase.operandA, 3);
      expect(useCase.operandB, 3);

      expect(memoryChanged, true);
      expect(operationChanged, true);
    });

    test('manages memory', () {
      bool memoryChanged = false;
      void onMemoryChanged() => memoryChanged = true;

      bool operationChanged = false;
      void onOperationChanged() => operationChanged = true;

      CalculatorUseCase useCase = CalculatorUseCase(
          operation: Add,
          operandA: 1,
          operandB: 2,
          onMemoryChanged: onMemoryChanged,
          onOperationChanged: onOperationChanged);

      expect(useCase.memory, null);
      useCase.memorise();
      expect(useCase.memory, 3);

      expect(memoryChanged, true);
      expect(operationChanged, false);

      useCase.resetMemory();
      expect(useCase.memory, null);
    });
  });
}
