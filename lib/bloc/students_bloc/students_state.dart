part of 'students_bloc.dart';

abstract class StudentsState extends Equatable {
  const StudentsState();

  @override
  List<Object> get props => [];
}

class StudentsInitial extends StudentsState {}

class StudentListLoadedState extends StudentsState {
  final List<Student> student;

  const StudentListLoadedState({required this.student});
}

class StudentDetailsLoadedState extends StudentsState {
  final StudentDetailModel studentDetailModel;

  const StudentDetailsLoadedState({required this.studentDetailModel});
}

class LoadingState extends StudentsState {}

class LoadedState extends StudentsState {}

class ErrorState extends StudentsState {
  final String errMsg;

  const ErrorState({required this.errMsg});
}
