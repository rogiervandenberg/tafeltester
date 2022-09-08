part of 'question_cubit.dart';

@immutable
abstract class QuestionState {}

class QuestionInitial extends QuestionState {}

class QuestionReset extends QuestionState {}

class QuestionLoaded extends QuestionState {
  final Assignment assignment;
  QuestionLoaded(this.assignment);
}

class FirstQuestion extends QuestionLoaded {
  final Assignment newAssignment;
  FirstQuestion(this.newAssignment) : super(newAssignment);
}

class AnswerGiven extends QuestionLoaded {
  final Assignment newAssignment;
  AnswerGiven(this.newAssignment) : super(newAssignment);
}

class LastAnswerGiven extends QuestionLoaded {
  final Assignment newAssignment;
  LastAnswerGiven(this.newAssignment) : super(newAssignment);
}
