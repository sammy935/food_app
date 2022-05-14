part of 'resume_bloc.dart';

abstract class ResumeState extends Equatable {
  const ResumeState();
}

class ResumeInitial extends ResumeState {
  @override
  List<Object> get props => [];
}

class GetTaskListInProgress extends ResumeState {
  @override
  String toString() => 'GetTaskListInProgress';

  @override
  List<Object?> get props => ['GetTaskListInProgress'];
}

class GetTaskListCompleted extends ResumeState {
  final List<String> resumes;

  const GetTaskListCompleted({required this.resumes});

  @override
  String toString() => 'GetTaskListCompleted';

  @override
  List<Object?> get props => [resumes];
}

class GetTaskListFailed extends ResumeState {
  final String? message;
  const GetTaskListFailed({this.message});

  @override
  String toString() => 'GetTaskListFailed';

  @override
  List<Object?> get props => ['GetTaskListFailed'];
}
