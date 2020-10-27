import 'package:flutter/material.dart';
import 'calculus/calculus.dart';

class Calculus extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: CalculusScreen(),
    );
  }
}
