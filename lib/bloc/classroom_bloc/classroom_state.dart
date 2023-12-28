part of 'classroom_bloc.dart';

abstract class ClassroomState extends Equatable {
  const ClassroomState();

  @override
  List<Object> get props => [];
}

class ClassroomInitial extends ClassroomState {}

class ClassroomListLoadedState extends ClassroomState {
  final List<Classroom> classroom;

  const ClassroomListLoadedState({required this.classroom});
}

class ClassroomDetailLoadedState extends ClassroomState {
  final ClassroomDetailModel classroomDetailModel;

  const ClassroomDetailLoadedState({required this.classroomDetailModel});
}

class ClassroomLoadedState extends ClassroomState {}

class ClassroomLoadingState extends ClassroomState {}

class ClassroomClearState extends ClassroomState {}
