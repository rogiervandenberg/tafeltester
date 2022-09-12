import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

import 'package:tafeltester/cubit/question_cubit.dart';
part 'timer_state.dart';

class TimerCubit extends Cubit<TimerState> {
  final QuestionCubit questionCubit;
  late StreamSubscription questionSubscription;
  Timer? durationTimer;
  Duration myDuration = Duration.zero;

  TimerCubit({required this.questionCubit})
      : super(const TimerInitial(Duration.zero)) {
    monitorQuestionsAnswered();
  }

  StreamSubscription<QuestionState> monitorQuestionsAnswered() {
    return questionSubscription = questionCubit.stream.listen((questionState) {
      if (questionState is FirstQuestion) {
        resetTimer();
        startTimer();
      } else if (questionState is LastAnswerGiven) {
        stopTimer();
      }
    });
  }

  void startTimer() {
    durationTimer =
        Timer.periodic(const Duration(seconds: 1), (_) => setNewValue());
  }

  void stopTimer() {
    durationTimer?.cancel();
  }

  void resetTimer() {
    stopTimer();
    myDuration = Duration.zero;
    emit(TimerUpdate(myDuration));
  }

  void setNewValue() {
    const reduceSecondsBy = 1;
    final seconds = myDuration.inSeconds + reduceSecondsBy;
    myDuration = Duration(seconds: seconds);
    emit(TimerUpdate(myDuration));
  }

  @override
  Future<void> close() {
    durationTimer?.cancel();
    questionSubscription.cancel();
    return super.close();
  }
}
