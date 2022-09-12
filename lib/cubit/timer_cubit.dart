import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'timer_state.dart';

class TimerCubit extends Cubit<TimerState> {
  TimerCubit() : super(const TimerInitial(Duration.zero));

  Timer? durationTimer;
  Duration myDuration = Duration.zero;

  void startTimer() {
    durationTimer =
        Timer.periodic(const Duration(seconds: 1), (_) => setNewValue());
  }

  void stopTimer() {
    durationTimer!.cancel();
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
    return super.close();
  }
}
