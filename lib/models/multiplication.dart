import 'dart:math';

class Multiplication {
  Multiplication({
    required this.factorX,
    required this.factorY,
    required this.solution,
  });

  final int factorX;
  final int factorY;
  final int solution;

  List<int> answerOptions() {
    List<int> answerOptions = [solution];
    var rng = Random();

    answerOptions.add(rng.nextInt(100));
    answerOptions.add(rng.nextInt(100));
    answerOptions.shuffle();
    return answerOptions;
  }

  @override
  String toString() {
    return "$factorX x $factorY";
  }
}
