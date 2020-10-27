import 'dart:math';

import 'package:flutter/material.dart';

import 'use_case.dart';

class CalculusScreen extends StatefulWidget {
  @override
  _CalculusScreenState createState() => _CalculusScreenState();
}

class _CalculusScreenState extends State<CalculusScreen> {
  num memory;
  num calculatorValue;

  void onCalulatorResultChanged(num value) {
    setState(() {
      calculatorValue = value;
    });
  }

  void onMemorise() {
    setState(() {
      memory = calculatorValue;
    });
  }

  void onResetMemory() {
    setState(() {
      memory = null;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: SafeArea(
          child: ListView(
            padding: const EdgeInsets.symmetric(horizontal: 24.0),
            children: <Widget>[
              Header(),
              Divider(indent: 10.0, endIndent: 10.0, height: 8.0),
              MemoryInfo(memory: memory),
              CalculatorInput(
                  memory: memory, onChanged: onCalulatorResultChanged),
              MemoryManagement(
                  onMemorise: onMemorise, onResetMemory: onResetMemory),
            ],
          ),
        ),
      ),
    );
  }
}

class Header extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Center(
          child:
              Text('Calculus', style: Theme.of(context).textTheme.headline4)),
      height: 150.0,
      padding: const EdgeInsets.only(top: 10.0, bottom: 10.0),
    );
  }
}

class MemoryInfo extends StatelessWidget {
  final num memory;

  const MemoryInfo({Key key, this.memory}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      child: Text('In memory: ${memory ?? ''}',
          style: Theme.of(context).textTheme.bodyText1),
    );
  }
}

enum Operand { A, B }

class CalculatorInput extends StatefulWidget {
  final num memory;
  final ValueChanged<num> onChanged;

  const CalculatorInput({Key key, this.memory, this.onChanged})
      : super(key: key);

  @override
  _CalculatorInputState createState() => _CalculatorInputState();
}

class _CalculatorInputState extends State<CalculatorInput> {
  final operations = <Operation, String>{
    Operation.addition: 'Addition',
    Operation.subtraction: 'Subtraction',
    Operation.multiplication: 'Multiplication',
    Operation.division: 'Division',
    Operation.sqrt: 'Square root',
  };

  Operation operation = Operation.addition;
  num operandA = 0;
  num operandB = 0;

  void onOperationChanged(Operation newOperation) {
    setState(() {
      operation = newOperation;
    });
    widget.onChanged(calculatorValue);
  }

  ValueChanged<String> onOperandChanged(Operand operand) => (String v) {
        double value = double.tryParse(v) ?? 0;
        setState(() {
          if (operand == Operand.A) {
            operandA = value;
          }
          if (operand == Operand.B) {
            operandB = value;
          }
        });
        widget.onChanged(calculatorValue);
      };

  num get calculatorValue {
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

  String get calculatorFormat {
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

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 10),
      child: Column(
        children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Text('Operation', style: Theme.of(context).textTheme.bodyText2),
              DropdownButton(
                value: operation,
                items: operations.entries
                    .map((entry) => DropdownMenuItem(
                        child: Text(entry.value), value: entry.key))
                    .toList(),
                onChanged: onOperationChanged,
              ),
            ],
          ),
          OperandInput(
              label: 'Operand A',
              initValue: operandA,
              memory: widget.memory,
              onChanged: onOperandChanged(Operand.A)),
          operation == Operation.sqrt
              ? SizedBox(height: 68)
              : OperandInput(
                  label: 'Operand B',
                  initValue: operandB,
                  memory: widget.memory,
                  onChanged: onOperandChanged(Operand.B)),
          Container(
              margin: const EdgeInsets.only(top: 10, bottom: 20),
              child: Text(
                  '$calculatorFormat = ${calculatorValue.toStringAsFixed(3)}')),
        ],
      ),
    );
  }
}

class OperandInput extends StatefulWidget {
  final String label;
  final num initValue;
  final num memory;
  final ValueChanged<String> onChanged;

  const OperandInput(
      {Key key, this.label, this.initValue, this.memory, this.onChanged})
      : super(key: key);

  @override
  _OperandInputState createState() => _OperandInputState();
}

class _OperandInputState extends State<OperandInput> {
  TextEditingController controller;

  @override
  void initState() {
    super.initState();
    controller = TextEditingController(text: '${widget.initValue}');
  }

  void onFromMemory() {
    if (widget.memory == null) return;

    setState(() {
      controller.text = '${widget.memory}';
    });
    widget.onChanged(controller.text);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 10, bottom: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.only(right: 8.0),
            child: Text(widget.label,
                style: Theme.of(context).textTheme.bodyText2),
          ),
          Flexible(
            child: TextField(
              controller: controller,
              keyboardType: TextInputType.number,
              textAlign: TextAlign.end,
              onChanged: widget.onChanged,
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 8.0),
            child: RaisedButton(
                onPressed: onFromMemory,
                child: Text('From memory',
                    style: Theme.of(context).textTheme.button)),
          ),
        ],
      ),
    );
  }
}

class MemoryManagement extends StatelessWidget {
  final void Function() onMemorise;
  final void Function() onResetMemory;

  const MemoryManagement({Key key, this.onMemorise, this.onResetMemory})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: IntrinsicWidth(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            RaisedButton(
              onPressed: onMemorise,
              child: Text('Memorise result',
                  style: Theme.of(context).textTheme.button),
            ),
            RaisedButton(
              onPressed: onResetMemory,
              child: Text('Reset memory',
                  style: Theme.of(context).textTheme.button),
            ),
          ],
        ),
      ),
    );
  }
}
