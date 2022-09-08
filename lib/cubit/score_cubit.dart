import 'package:bloc/bloc.dart';

class ScoreCubit extends Cubit<int> {
  ScoreCubit() : super(0);

  /// Add 1 to the current state.
  void increment() {
    print(state + 1);
    emit(state + 1);
  }

  /// Subtract 1 from the current state.
  void decrement() => emit(state - 1);
}
