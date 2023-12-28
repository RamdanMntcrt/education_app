import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:edu_app/utils/api_contants.dart';
import 'package:edu_app/utils/api_query.dart';

class StudentsRepo {
  String apiKey = '6edFB';
  ApiQuery apiQuery = ApiQuery();

  Future<Response?> getStudentList() async {
    Response? response = await apiQuery.getQuery(
        "${ApiConst.studentsUrl}?api_key=$apiKey",
        'student_List_api',
        true,
        true,
        false);
    log(response!.statusCode.toString());
    return response;
  }

  Future<Response?> getStudentDetails(int id) async {
    Response? response = await apiQuery.getQuery(
        "${ApiConst.studentsUrl}/$id?api_key=$apiKey",
        'student_details_api',
        true,
        true,
        false);
    log(response!.statusCode.toString());
    return response;
  }
}
