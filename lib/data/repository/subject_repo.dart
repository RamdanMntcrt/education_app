import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:edu_app/utils/api_contants.dart';
import 'package:edu_app/utils/api_query.dart';

class SubjectRepo {
  ApiQuery apiQuery = ApiQuery();
  String apiKey = '6edFB';

  Future<Response?> getSubjectList() async {
    Response? response = await apiQuery.getQuery(
        '${ApiConst.subjectsUrl}?api_key=$apiKey',
        'subject_list_api',
        true,
        true,
        false);
    return response;
  }

  Future<Response?> getSubjectDetails(int id) async {
    Response? response = await apiQuery.getQuery(
        "${ApiConst.subjectsUrl}$id?api_key=$apiKey",
        'subject_details_api',
        true,
        true,
        false);
    log(response!.statusCode.toString());
    return response;
  }
}
