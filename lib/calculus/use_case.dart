import 'operation.dart';

enum Operand { A, B }

class CalculatorUseCase {
  num memory;
  Operation operation;
  num operandA;
  num operandB;
  void Function() onMemoryChanged;
  void Function() onOperationChanged;

  CalculatorUseCase(
      {Operation operation,
      this.operandA = 0,
      this.operandB = 0,
      this.onMemoryChanged,
      this.onOperationChanged}) {
    this.operation = operation ?? Add;
  }

  @override
  String toString() =>
      'operation: $operation, A: $operandA, B: $operandB, value: $value';

  num get value => operation.oper(operandB)(operandA);
  String get format => operation.format(operandB)(operandA);

  ///
  /// User sets operation.
  ///
  void setOperation(Operation value) {
    operation = value;
    onOperationChanged?.call();
  }

  num operandValue(Operand operand) =>
      (operand == Operand.A) ? operandA : operandB;

  void _setOperandA(num v) => operandA = v;
  void _setOperandB(num v) => operandB = v;

  ///
  /// User sets new operand value.
  ///
  void Function(num) setOperand(Operand operand) {
    onOperationChanged?.call();
    return (operand == Operand.A) ? _setOperandA : _setOperandB;
  }

  ///
  /// User sets operand value from memory.
  ///
  void fromMemory(Operand operand) {
    if (memory == null) return;
    setOperand(operand)(memory);
  }

  ///
  /// User saves operation result to memory
  ///
  void memorise() {
    memory = value;
    onMemoryChanged?.call();
  }

  ///
  /// User resets memory
  ///
  void resetMemory() {
    memory = null;
    onMemoryChanged?.call();
  }
}
