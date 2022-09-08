part of 'question_cubit.dart';

@immutable
abstract class QuestionState {}

class QuestionInitial extends QuestionState {}

class QuestionChanged extends QuestionState {
  final Multiplication question;
  QuestionChanged(this.question);
}
