import 'dart:math';

enum Operation { addition, subtraction, division, multiplication, sqrt }

class CalculatorUseCase {
  num memory;
  Operation operation;
  num operandA;
  num operandB;

  CalculatorUseCase(
      {this.operation = Operation.addition,
      this.operandA = 0,
      this.operandB = 0});

  @override
  String toString() =>
      'operation: $operation, A: $operandA, B: $operandB, value: $value';

  num get value {
    switch (operation) {
      case Operation.addition:
        return operandA + operandB;
      case Operation.subtraction:
        return operandA - operandB;
      case Operation.multiplication:
        return operandA * operandB;
      case Operation.division:
        return operandA / operandB;
      case Operation.sqrt:
        return sqrt(operandA);
      default:
        return 0;
    }
  }

  String get format {
    switch (operation) {
      case Operation.addition:
        return '$operandA + $operandB';
      case Operation.subtraction:
        return '$operandA - $operandB';
      case Operation.multiplication:
        return '$operandA * $operandB';
      case Operation.division:
        return '$operandA / $operandB';
      case Operation.sqrt:
        return 'sqrt($operandA)';
      default:
        return '';
    }
  }

  ///
  /// User sets operation.
  ///
  void setOperation(Operation value) {
    operation = value;
  }

  ///
  /// User saves operation result to memory
  ///
  void memorise() {
    memory = value;
  }

  ///
  /// User resets memory
  ///
  void resetMemory() {
    memory = null;
  }
}
