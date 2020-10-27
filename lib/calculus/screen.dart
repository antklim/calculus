import 'package:flutter/material.dart';

class CalculusScreen extends StatelessWidget {
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
    return Container(
      alignment: Alignment.center,
      child: Text('In memory: <Some data in memory>',
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

class MemoryManagement extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: IntrinsicWidth(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            RaisedButton(
              onPressed: () {},
              child: Text('Memorise result',
                  style: Theme.of(context).textTheme.button),
            ),
            RaisedButton(
              onPressed: () {},
              child: Text('Reset memory',
                  style: Theme.of(context).textTheme.button),
            ),
          ],
        ),
      ),
    );
  }
}
