import 'dart:math';

typedef Operator = num Function(num) Function(num);
typedef OperatorFmt = String Function(num) Function(num);

class Operation {
  final String name;
  final Operator oper;
  final OperatorFmt format;

  Operation({this.name, this.oper, this.format});

  @override
  String toString() => name;
}

final Add = Operation(
  name: 'Addition',
  oper: (num b) => (num a) => a + b,
  format: (num b) => (num a) => '$a + $b',
);

final Sub = Operation(
  name: 'Subtraction',
  oper: (num b) => (num a) => a - b,
  format: (num b) => (num a) => '$a - $b',
);

final Mul = Operation(
  name: 'Multiplication',
  oper: (num b) => (num a) => a * b,
  format: (num b) => (num a) => '$a * $b',
);

final Div = Operation(
  name: 'Division',
  oper: (num b) => (num a) => a / b,
  format: (num b) => (num a) => '$a / $b',
);

final Sqrt = Operation(
  name: 'Square root',
  oper: (_) => (num a) => sqrt(a),
  format: (_) => (num a) => 'sqrt($a)',
);
