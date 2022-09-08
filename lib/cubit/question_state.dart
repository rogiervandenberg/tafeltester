part of 'question_cubit.dart';

// @immutable
abstract class QuestionState {
  Multiplication? question;
  QuestionState(this.question);
}

class QuestionInitial extends QuestionState {
  QuestionInitial() : super(null);
}

class QuestionChanged extends QuestionState {
  final Multiplication newQuestion;
  QuestionChanged(this.newQuestion) : super(newQuestion);
}
