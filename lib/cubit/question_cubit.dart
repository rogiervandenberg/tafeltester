import 'package:bloc/bloc.dart';
import 'package:flutter/foundation.dart';
import 'package:tafeltester/models/multiplication.dart';

part 'question_state.dart';

class QuestionCubit extends Cubit<QuestionState> {
  QuestionCubit() : super(QuestionInitial());
  List<Multiplication> multiplications = [];
  late Multiplication currentExercise;

  List<int> possibleTables = [1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 25];

  void setMultiplications() {
    // List<int> tablesToPractice = [1, 2, 3, 4, 5, 6, 7, 8, 9, 10];
    List<int> tablesToPractice = [3, 4, 6, 7, 8];

    for (var table in tablesToPractice) {
      for (var i = 1; i <= 10; i++) {
        multiplications.add(
            Multiplication(factorX: i, factorY: table, solution: i * table));
      }
    }
    multiplications.shuffle();
  }

  void changeQuestion() {
    if (multiplications.isNotEmpty) {
      currentExercise = multiplications.removeLast();
    }
    emit(QuestionChanged(currentExercise));
  }

  void giveAnswer(int answer) {
    if (answer != currentExercise.solution) {
      // Wrong answer
      // ScoreCubit().decrement();
      multiplications.add(currentExercise);
      multiplications.shuffle();
    } else {
      // ScoreCubit().increment();
    }
    changeQuestion();
  }

  void start() {
    if (kDebugMode) {
      print("start");
    }
    setMultiplications();
    changeQuestion();
  }
}
