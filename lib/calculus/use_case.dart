import 'dart:math';

import 'package:flutter/material.dart';

enum Operation { addition, subtraction, division, multiplication, sqrt }
enum Operand { A, B }

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

  num operandValue(Operand operand) =>
      (operand == Operand.A) ? operandA : operandB;

  void _setOperandA(num v) => operandA = v;
  void _setOperandB(num v) => operandB = v;

  ///
  /// User sets new operand value.
  ///
  ValueChanged<num> setOperand(Operand operand) =>
      (operand == Operand.A) ? _setOperandA : _setOperandB;

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
