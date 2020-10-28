import 'package:flutter/material.dart';

import 'operation.dart';
import 'use_case.dart';

class CalculatorState extends ChangeNotifier {
  CalculatorUseCase _useCase;

  CalculatorState() {
    _useCase = CalculatorUseCase(
        onMemoryChanged: onMemoryChanged,
        onOperationChanged: onOperationChanged);
  }

  void onMemoryChanged() => notifyListeners();
  void onOperationChanged() => notifyListeners();

  void setOperation(Operation operation) => _useCase.setOperation(operation);

  ValueChanged<String> setOperand(Operand operand) => (String v) {
        var value = double.tryParse(v) ?? 0.0;
        return _useCase.setOperand(operand)(value);
      };

  void fromMemory(Operand operand) => _useCase.fromMemory(operand);

  void memorise() => _useCase.memorise();

  void resetMemory() => _useCase.resetMemory();
}
