import 'package:bloc/bloc.dart';
import 'package:flutter/foundation.dart';
import 'package:tafeltester/models/multiplication.dart';

import '../models/assignment.dart';

part 'question_state.dart';

class QuestionCubit extends Cubit<QuestionState> {
  QuestionCubit() : super(QuestionInitial());
  List<Multiplication> multiplications = [];
  late Multiplication currentExercise;

  List<int> possibleTables = [1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 25];

  void setMultiplications() {
    // List<int> tablesToPractice = [1, 2, 3, 4, 5, 6, 7, 8, 9, 10];
    // List<int> tablesToPractice = [3, 4, 6, 7, 8];
    List<int> tablesToPractice = [1];

    for (var table in tablesToPractice) {
      for (var i = 1; i <= 10; i++) {
        multiplications.add(
            Multiplication(factorX: i, factorY: table, solution: i * table));
      }
    }
    multiplications.shuffle();
  }

  void changeQuestion({required bool previousWasCorrect}) {
    if (multiplications.isNotEmpty) {
      currentExercise = multiplications.removeLast();
    }

    if (multiplications.isNotEmpty) {
      emit(AnswerGiven(Assignment(
        multiplication: currentExercise,
        previousWasCorrect: previousWasCorrect,
      )));
    } else {
      emit(LastAnswerGiven(Assignment(
        multiplication: currentExercise,
        previousWasCorrect: previousWasCorrect,
      )));
    }
  }

  void giveAnswer(int answer) {
    if (answer != currentExercise.solution) {
      // Wrong answer
      // ScoreCubit().decrement();
      multiplications.add(currentExercise);
      multiplications.shuffle();
      changeQuestion(previousWasCorrect: false);
    } else {
      // ScoreCubit().increment();
      changeQuestion(previousWasCorrect: true);
    }
  }

  void start() {
    if (kDebugMode) {
      print("start");
    }
    setMultiplications();
    // changeQuestion(previousWasCorrect: true);
    currentExercise = multiplications.removeLast();
    emit(FirstQuestion(Assignment(
      multiplication: currentExercise,
      previousWasCorrect: true,
    )));
  }
}
