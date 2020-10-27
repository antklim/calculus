import 'package:flutter/material.dart';

class CalculusScreen extends StatefulWidget {
  @override
  _CalculusScreenState createState() => _CalculusScreenState();
}

class _CalculusScreenState extends State<CalculusScreen> {
  num memory;
  num calculatorResult;

  void onMemorise() {
    setState(() {
      memory = calculatorResult;
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
              CalculatorInput(),
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

enum Operation { addition, subtraction, division, multiplication, sqrt }

class CalculatorInput extends StatefulWidget {
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

  void onOperationChanged(Operation newOperation) {
    setState(() {
      operation = newOperation;
    });
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
          Operand(label: 'Operand A', initValue: 0),
          operation == Operation.sqrt
              ? SizedBox(height: 68)
              : Operand(label: 'Operand B', initValue: 0),
          Container(
              margin: const EdgeInsets.only(top: 10, bottom: 20),
              child: Text(
                '(1 + 2) = 3',
              )),
        ],
      ),
    );
  }
}

class Operand extends StatefulWidget {
  final String label;
  final num initValue;

  const Operand({Key key, this.label, this.initValue}) : super(key: key);

  @override
  _OperandState createState() => _OperandState();
}

class _OperandState extends State<Operand> {
  TextEditingController controller;

  @override
  void initState() {
    super.initState();
    controller = TextEditingController(text: '${widget.initValue}');
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
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 8.0),
            child: RaisedButton(
                onPressed: () {},
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
