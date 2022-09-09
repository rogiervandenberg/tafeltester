import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:flutter/foundation.dart';
import 'package:tafeltester/cubit/settings_cubit.dart';
import 'package:tafeltester/models/multiplication.dart';

import '../models/assignment.dart';
import '../models/settings.dart';

part 'question_state.dart';

class QuestionCubit extends Cubit<QuestionState> {
  final SettingsCubit settingsCubit;
  late StreamSubscription settingsSubscription;
  List<Multiplication> multiplications = [];
  late Multiplication currentExercise;

  late List<int> tablesToPractice;

  late int totalAmount;

  QuestionCubit({required this.settingsCubit}) : super(QuestionInitial()) {
    setTablesToPractice();

    settingsSubscription = settingsCubit.stream.listen((settingsState) {
      tablesToPractice = settingsState.settings.tablesToArray();
      start();
    });
  }

  Future<void> setTablesToPractice() async {
    tablesToPractice = await Settings.getSavedTables();
  }

  void setMultiplications() {
    for (var table in tablesToPractice) {
      for (var i = 1; i <= 10; i++) {
        multiplications.add(
            Multiplication(factorX: i, factorY: table, solution: i * table));
      }
    }
    multiplications.shuffle();
    totalAmount = multiplications.length;
  }

  void changeQuestion({required bool previousWasCorrect}) {
    if (multiplications.isNotEmpty) {
      currentExercise = multiplications.removeLast();
      emit(
        AnswerGiven(
          Assignment(
              multiplication: currentExercise,
              previousWasCorrect: previousWasCorrect,
              progress: ((10 * tablesToPractice.length.toDouble()) -
                      multiplications.length -
                      1) /
                  10,
              totalAmount: totalAmount),
        ),
      );
    } else {
      emit(LastAnswerGiven(Assignment(
          multiplication: currentExercise,
          previousWasCorrect: previousWasCorrect,
          progress: 1.0,
          totalAmount: totalAmount)));
    }
  }

  void giveAnswer(int answer) {
    if (answer != currentExercise.solution) {
      // Wrong answer

      multiplications.add(currentExercise);
      multiplications.shuffle();
      totalAmount++;
      changeQuestion(previousWasCorrect: false);
    } else {
      changeQuestion(previousWasCorrect: true);
    }
  }

  void start() {
    _reset();
    setMultiplications();
    // changeQuestion(previousWasCorrect: true);
    currentExercise = multiplications.removeLast();
    emit(FirstQuestion(Assignment(
        multiplication: currentExercise,
        previousWasCorrect: true,
        progress: 0.0,
        totalAmount: totalAmount)));
  }

  void _reset() {
    multiplications = [];
  }

  @override
  Future<void> close() {
    settingsSubscription.cancel();
    return super.close();
  }
}
