part of 'subject_bloc.dart';

abstract class SubjectEvent extends Equatable {
  const SubjectEvent();

  @override
  List<Object> get props => [];
}

class LoadSubjectListEvent extends SubjectEvent {}

class GetSubjectDetailsEvent extends SubjectEvent {
  final int id;

  const GetSubjectDetailsEvent({required this.id});
}
