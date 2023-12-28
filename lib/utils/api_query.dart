import 'dart:developer';
import 'dart:io';

import 'package:cookie_jar/cookie_jar.dart';
import 'package:dio/dio.dart';
import 'package:dio_cookie_manager/dio_cookie_manager.dart';
import 'package:dio_http_cache/dio_http_cache.dart';
import 'package:path_provider/path_provider.dart';

import 'api_contants.dart';

class ApiQuery {
  var dio = Dio();

  final DioCacheManager dioCacheManager = DioCacheManager(CacheConfig());

  Future<Response?> postQuery(
    String baseUrl,
    String url,
    Map<String, String> headers,
    dynamic data,
    String apiName,
  ) async {
    Response response;
    try {
      Options options = Options(headers: headers);

      //dio.options.headers = headers;
      dio.interceptors.add(InterceptorsWrapper(
        onRequest: (options, handler) {
          return handler.next(options); //continue
        },
        onResponse: (response, handler) {
          return handler.next(response); //continue
        },
        onError: (DioError e, handler) {
          return handler.next(e); //continue
        },
      ));
      log(baseUrl + url);
      response = await dio.post(baseUrl + url, data: data, options: options);

      log(response.statusCode.toString());
      return response;
    } on DioError catch (exception) {
      if (exception.toString().contains('SocketException')) {
        return exception.response;
      } else if (exception.type == DioErrorType.receiveTimeout ||
          exception.type == DioErrorType.connectTimeout) {
        return exception.response;
      } else {
        return exception.response;
      }
    }
  }

  Future<Response?> getQuery(
    String url,
    String apiName,
    bool isCached,
    bool isBaseUrlToBeAdded,
    bool forceRefresh,
  ) async {
    Directory appDocDir = await getApplicationDocumentsDirectory();
    String appDocPath = appDocDir.path;

    Options _cacheOptions = buildCacheOptions(const Duration(days: 7),
        forceRefresh: forceRefresh, primaryKey: apiName);
    var cookieJar = PersistCookieJar(
        ignoreExpires: true, storage: FileStorage(appDocPath + "/.cookies/"));
    Response? response;

    try {
      dio.interceptors.add(CookieManager(cookieJar));

      /*Options options = Options(headers: headers);*/

      if (isCached) {
        dio.interceptors.add(dioCacheManager.interceptor);
      }
      dio.interceptors.add(InterceptorsWrapper(
        onRequest: (options, handler) {
          return handler.next(options); //continue
        },
        onResponse: (response, handler) {
          return handler.next(response); //continue
        },
        onError: (DioError e, handler) {
          print(e.toString());
          return handler.next(e); //continue
        },
      ));
      if (isBaseUrlToBeAdded) {
        if (isCached) {
          response = await dio.get(
            ApiConst.baseUrl + url, /*options: options, queryParameters: query*/
          );
          log(ApiConst.baseUrl + url);
        } else {
          response = await dio.get(
            ApiConst.baseUrl + url,
            /* options: options,*/
            /*queryParameters: (query != null) ? query : null*/
          );
          log(ApiConst.baseUrl + url);
        }
      } else {
        if (isCached) {
          response = await dio.get(
            url,
            /*options: options,*/
            /*queryParameters: (query != null) ? query : null*/
          );
          log(ApiConst.baseUrl + url);
        } else {
          response = await dio.get(
            url,
            /* options: options,
              queryParameters: (query != null) ? query : null*/
          );
          log(ApiConst.baseUrl + url);
        }
      }
      log(ApiConst.baseUrl + url);
      return response;
    } on DioError catch (exception) {
      if (exception.toString().contains('SocketException')) {
        return exception.response;
      } else if (exception.type == DioErrorType.receiveTimeout ||
          exception.type == DioErrorType.connectTimeout) {
        return exception.response;
      } else {
        return exception.response;
      }
    }
  }
}
