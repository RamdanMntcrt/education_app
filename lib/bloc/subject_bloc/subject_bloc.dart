import 'dart:async';
import 'dart:convert';
import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:edu_app/data/models/subject_detail_model.dart';
import 'package:edu_app/data/repository/subject_repo.dart';
import 'package:equatable/equatable.dart';

import '../../data/models/subject_model.dart';

part 'subject_event.dart';

part 'subject_state.dart';

SubjectRepo subjectRepo = SubjectRepo();

class SubjectBloc extends Bloc<SubjectEvent, SubjectState> {
  SubjectBloc() : super(SubjectInitial()) {
    on<SubjectEvent>((event, emit) {
      // TODO: implement event handler
    });

    on<LoadSubjectListEvent>((event, emit) async {
      try {
        emit(SubjectLoadingState());

        Response? response = await subjectRepo.getSubjectList();
        log(response!.statusCode.toString());
        if (response.statusCode == 200) {
          emit(SubjectLoadedState());

          var subList = json.encode(response.data);
          List<Subject>? subjects = subjectListModelFromJson(subList).subjects;

          emit(SubjectListLoadedState(subject: subjects!));
        }
      } catch (e) {
        log(e.toString());
      }
    });

    on<GetSubjectDetailsEvent>((event, emit) async {
      try {
        emit(SubjectLoadingState());
        log(event.id.toString());

        Response? response = await subjectRepo.getSubjectDetails(event.id);
        if (response!.statusCode == 200) {
          log(response.data.toString());
          emit(SubjectLoadedState());

          var subjectDetails = json.encode(response.data);

          SubjectDetailModel subjectDetailModel =
              subjectDetailModelFromJson(subjectDetails);

          emit(SubjectDetailsLoadedState(
              subjectDetailModel: subjectDetailModel));
        }
      } catch (e) {
        log(e.toString());
      }
    });
  }
}
