import 'package:flutter/material.dart';

import 'use_case.dart';

class CalculusScreen extends StatefulWidget {
  @override
  _CalculusScreenState createState() => _CalculusScreenState();
}

class _CalculusScreenState extends State<CalculusScreen> {
  CalculatorUseCase useCase = CalculatorUseCase();

  void onMemorise() {
    setState(() {
      useCase.memorise();
    });
  }

  void onResetMemory() {
    setState(() {
      useCase.resetMemory();
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
              MemoryInfo(memory: useCase.memory),
              CalculatorInput(useCase: useCase),
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

class CalculatorInput extends StatefulWidget {
  final CalculatorUseCase useCase;

  const CalculatorInput({Key key, this.useCase}) : super(key: key);

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

  void onOperationChanged(Operation newOperation) {
    widget.useCase.setOperation(newOperation);
    setState(() {});
  }

  void onOperandChanged() {
    // rebuilding calculation result widget
    setState(() {});
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
                value: widget.useCase.operation,
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
              operand: Operand.A,
              useCase: widget.useCase,
              onChanged: onOperandChanged),
          widget.useCase.operation == Operation.sqrt
              ? SizedBox(height: 68)
              : OperandInput(
                  label: 'Operand B',
                  operand: Operand.B,
                  useCase: widget.useCase,
                  onChanged: onOperandChanged),
          Container(
              margin: const EdgeInsets.only(top: 10, bottom: 20),
              child: Text(
                  '${widget.useCase.format} = ${widget.useCase.value.toStringAsFixed(3)}')),
        ],
      ),
    );
  }
}

class OperandInput extends StatefulWidget {
  final String label;
  final Operand operand;
  final CalculatorUseCase useCase;
  final Function onChanged;

  const OperandInput(
      {Key key, this.label, this.operand, this.useCase, this.onChanged})
      : super(key: key);

  @override
  _OperandInputState createState() => _OperandInputState();
}

class _OperandInputState extends State<OperandInput> {
  TextEditingController controller;

  @override
  void initState() {
    super.initState();
    controller = TextEditingController(
        text: '${widget.useCase.operandValue(widget.operand)}');
  }

  void onFromMemory() {
    if (widget.useCase.memory == null) return;

    setState(() {
      controller.text = '${widget.useCase.memory}';
    });
    widget.useCase.fromMemory(widget.operand);
    widget.onChanged();
  }

  void onChanged(String v) {
    double value = double.tryParse(v) ?? 0;
    widget.useCase.setOperand(widget.operand)(value);
    widget.onChanged();
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
              onChanged: onChanged,
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
