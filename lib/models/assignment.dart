import 'multiplication.dart';

class Assignment {
  Assignment(
      {required this.multiplication,
      required this.previousWasCorrect,
      required this.progress,
      required this.totalAmount});

  final Multiplication multiplication;
  final bool previousWasCorrect;
  final double progress;
  final int totalAmount;

  @override
  String toString() {
    return multiplication.toString();
  }
}
