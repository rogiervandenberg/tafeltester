import 'multiplication.dart';

class Assignment {
  Assignment({
    required this.multiplication,
    required this.previousWasCorrect,
  });

  final Multiplication multiplication;
  final bool previousWasCorrect;

  @override
  String toString() {
    return multiplication.toString();
  }
}
