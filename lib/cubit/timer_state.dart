part of 'timer_cubit.dart';

@immutable
abstract class TimerState {
  final Duration duration;
  const TimerState(this.duration);
}

class TimerInitial extends TimerState {
  final Duration newDuration;
  const TimerInitial(this.newDuration) : super(newDuration);
}

class TimerUpdate extends TimerState {
  final Duration newDuration;
  const TimerUpdate(this.newDuration) : super(newDuration);
}
