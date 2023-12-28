part of 'classroom_bloc.dart';

abstract class ClassroomEvent extends Equatable {
  const ClassroomEvent();

  @override
  List<Object> get props => [];
}

class GetClassroomListEvent extends ClassroomEvent {}

class GetClassDetailEvent extends ClassroomEvent {
  final int id;

  const GetClassDetailEvent({required this.id});
}
