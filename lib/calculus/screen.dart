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
