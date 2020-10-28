import 'package:calculus/calculus/state.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'operation.dart';
import 'use_case.dart';

class CalculusScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<CalculatorState>(
        create: (_) => CalculatorState(),
        builder: (context, _) => CalculusScreenContainer());
  }
}

class CalculusScreenContainer extends StatelessWidget {
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
              MemoryInfo(),
              CalculatorInput(),
              MemoryManagement(),
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
  @override
  Widget build(BuildContext context) {
    CalculatorState state = Provider.of<CalculatorState>(context);

    return Container(
      alignment: Alignment.center,
      child: Text('In memory: ${state.memory ?? ''}',
          style: Theme.of(context).textTheme.bodyText1),
    );
  }
}

class CalculatorInput extends StatefulWidget {
  @override
  _CalculatorInputState createState() => _CalculatorInputState();
}

class _CalculatorInputState extends State<CalculatorInput> {
  final operations = <Operation>[Add, Sub, Mul, Div, Sqrt];

  @override
  Widget build(BuildContext context) {
    CalculatorState state = Provider.of<CalculatorState>(context);

    return Container(
      margin: const EdgeInsets.only(top: 10),
      child: Column(
        children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Text('Operation', style: Theme.of(context).textTheme.bodyText2),
              DropdownButton(
                value: state.operation,
                items: operations
                    .map((entry) =>
                        DropdownMenuItem(child: Text(entry.name), value: entry))
                    .toList(),
                onChanged: state.setOperation,
              ),
            ],
          ),
          OperandInput(label: 'Operand A', operand: Operand.A),
          state.operation == Sqrt
              ? SizedBox(height: 68)
              : OperandInput(label: 'Operand B', operand: Operand.B),
          Container(
              margin: const EdgeInsets.only(top: 10, bottom: 20),
              child:
                  Text('${state.format} = ${state.value.toStringAsFixed(3)}')),
        ],
      ),
    );
  }
}

class OperandInput extends StatefulWidget {
  final String label;
  final Operand operand;

  const OperandInput({Key key, this.label, this.operand}) : super(key: key);

  @override
  _OperandInputState createState() => _OperandInputState();
}

class _OperandInputState extends State<OperandInput> {
  TextEditingController controller;

  @override
  void initState() {
    super.initState();
    final CalculatorState _state =
        Provider.of<CalculatorState>(context, listen: false);
    controller =
        TextEditingController(text: '${_state.operandValue(widget.operand)}');
  }

  void onFromMemory() {
    final CalculatorState _state =
        Provider.of<CalculatorState>(context, listen: false);

    setState(() {
      controller.text = '${_state.memory}';
    });
    _state.fromMemory(widget.operand);
  }

  @override
  Widget build(BuildContext context) {
    CalculatorState state = Provider.of<CalculatorState>(context);

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
              onChanged: state.setOperand(widget.operand),
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
  @override
  Widget build(BuildContext context) {
    CalculatorState state = Provider.of<CalculatorState>(context);

    return Center(
      child: IntrinsicWidth(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            RaisedButton(
              onPressed: state.memorise,
              child: Text('Memorise result',
                  style: Theme.of(context).textTheme.button),
            ),
            RaisedButton(
              onPressed: state.resetMemory,
              child: Text('Reset memory',
                  style: Theme.of(context).textTheme.button),
            ),
          ],
        ),
      ),
    );
  }
}
