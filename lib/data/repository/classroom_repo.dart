import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:edu_app/utils/api_contants.dart';
import 'package:edu_app/utils/api_query.dart';

class ClassroomRepo {
  String apiKey = '6edFB';
  ApiQuery apiQuery = ApiQuery();

  Future<Response?> getClassroomList() async {
    Response? response = await apiQuery.getQuery(
        "${ApiConst.classroomUrl}?api_key=$apiKey",
        'classroom_list_api',
        true,
        true,
        false);
    log(response!.statusCode.toString());
    return response;
  }

  Future<Response?> getClassroomDetail(String id) async {
    Response? response = await apiQuery.getQuery(
        "${ApiConst.classroomUrl}$id?api_key=$apiKey",
        'classroom_detail_api',
        true,
        true,
        false);
    log(response!.statusCode.toString());
    return response;
  }
}
