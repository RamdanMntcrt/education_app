part of 'subject_bloc.dart';

abstract class SubjectState extends Equatable {
  const SubjectState();

  @override
  List<Object> get props => [];
}

class SubjectInitial extends SubjectState {}

class SubjectListLoadedState extends SubjectState {
  final List<Subject> subject;

  const SubjectListLoadedState({required this.subject});
}

class SubjectDetailsLoadedState extends SubjectState {
  final SubjectDetailModel subjectDetailModel;

  const SubjectDetailsLoadedState({required this.subjectDetailModel});
}

class SubjectLoadingState extends SubjectState {}

class SubjectLoadedState extends SubjectState {}

class SubjectClearState extends SubjectState {}
