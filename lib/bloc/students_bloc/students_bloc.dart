import 'dart:convert';
import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:edu_app/data/models/student_detail_model.dart';
import 'package:edu_app/data/models/student_model.dart';
import 'package:edu_app/data/repository/student_repo.dart';
import 'package:equatable/equatable.dart';

part 'students_event.dart';

part 'students_state.dart';

StudentsRepo studentsRepo = StudentsRepo();

class StudentsBloc extends Bloc<StudentsEvent, StudentsState> {
  StudentsBloc() : super(StudentsInitial()) {
    on<StudentsEvent>((event, emit) {
      // TODO: implement event handler
    });

    on<GetStudentsListEvent>((event, emit) async {
      try {
        emit(LoadingState());

        Response? response = await studentsRepo.getStudentList();
        if (response!.statusCode == 200) {
          emit(LoadedState());

          var students = json.encode(response.data);

          List<Student>? studentData = studentModelFromJson(students).students;
          emit(StudentListLoadedState(student: studentData!));
        }
      } catch (e) {
        log(e.toString());
      }
    });

    on<GetStudentDetailEvent>((event, emit) async {
      try {
        emit(LoadingState());

        Response? response = await studentsRepo.getStudentDetails(event.id);
        if (response!.statusCode == 200) {
          log(response.data.toString());
          emit(LoadedState());

          var studentDetails = json.encode(response.data);

          StudentDetailModel studentDetailModel =
              studentDetailModelFromJson(studentDetails);

          emit(StudentDetailsLoadedState(
              studentDetailModel: studentDetailModel));
        }
      } catch (e) {
        log(e.toString());
      }
    });
  }
}
