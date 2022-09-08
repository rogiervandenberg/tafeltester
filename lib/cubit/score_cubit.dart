import 'dart:async';

import 'package:bloc/bloc.dart';

import 'package:tafeltester/cubit/question_cubit.dart';

class ScoreCubit extends Cubit<int> {
  final QuestionCubit questionCubit;
  late StreamSubscription questionSubscription;

  ScoreCubit({required this.questionCubit}) : super(0) {
    monitorQuestionsAnswered();
  }

  StreamSubscription<QuestionState> monitorQuestionsAnswered() {
    return questionSubscription = questionCubit.stream.listen((questionState) {
      if (questionState is QuestionLoaded) {
        if (questionState.assignment.previousWasCorrect) {
          increment();
        } else {
          decrement();
        }
      }

      if (questionState is FirstQuestion) {
        emit(0);
      }

      if (questionState is QuestionReset) {
        emit(0);
      }
    });
  }

  /// Add 1 to the current state.
  void increment() => emit(state + 1);

  /// Subtract 1 from the current state.
  void decrement() => emit(state - 1);

  @override
  Future<void> close() {
    questionSubscription.cancel();
    return super.close();
  }
}
