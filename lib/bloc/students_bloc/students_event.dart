part of 'students_bloc.dart';

abstract class StudentsEvent extends Equatable {
  const StudentsEvent();

  @override
  List<Object> get props => [];
}

class GetStudentsListEvent extends StudentsEvent {}

class GetStudentDetailEvent extends StudentsEvent {
  final int id;

  const GetStudentDetailEvent({required this.id});
}
