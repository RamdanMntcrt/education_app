import 'dart:async';
import 'dart:convert';
import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:edu_app/data/models/classroom_detail_model.dart';
import 'package:edu_app/data/models/classroom_model.dart';
import 'package:edu_app/data/repository/classroom_repo.dart';
import 'package:equatable/equatable.dart';

part 'classroom_event.dart';

part 'classroom_state.dart';

ClassroomRepo classroomRepo = ClassroomRepo();

class ClassroomBloc extends Bloc<ClassroomEvent, ClassroomState> {
  ClassroomBloc() : super(ClassroomInitial()) {
    on<ClassroomEvent>((event, emit) {
      // TODO: implement event handler
    });

    on<GetClassroomListEvent>((event, emit) async {
      emit(ClassroomLoadingState());

      Response? response = await classroomRepo.getClassroomList();
      log(response!.statusCode.toString());
      emit(ClassroomLoadingState());
      if (response.statusCode == 200) {
        var classroomList = json.encode(response.data);

        List<Classroom>? classroomModel =
            classroomModelFromJson(classroomList).classrooms;
        emit(ClassroomListLoadedState(classroom: classroomModel!));
      }
    });

    on<GetClassDetailEvent>((event, emit) async {
      emit(ClassroomLoadingState());

      Response? response =
          await classroomRepo.getClassroomDetail(event.id.toString());
      log(response!.statusCode.toString());
      if (response.statusCode == 200) {
        emit(ClassroomLoadedState());
        var classDetail = json.encode(response.data);

        ClassroomDetailModel? classroomDetailModel =
            classroomDetailModelFromJson(classDetail);

        emit(ClassroomDetailLoadedState(
            classroomDetailModel: classroomDetailModel));
      }
    });
  }
}
