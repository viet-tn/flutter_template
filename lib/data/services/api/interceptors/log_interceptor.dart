import 'dart:convert';

import 'package:dio/dio.dart';

import '../../../../utils/loggers/logger.dart';

class LogInterceptor extends Interceptor {
  static const _jsonEncoder = JsonEncoder.withIndent('  ');

  void logRequest(RequestOptions options) {
    Log.i(
      'REQ - [${options.method}] ${options.uri}\nHeader: ${_jsonEncoder.convert(options.headers)}\nExtra: ${_jsonEncoder.convert(options.extra)}\nRequest body: ${options.data}',
    );
  }

  void logResponse(Response response) {
    Log.i('''
      RES - [${response.requestOptions.method}] ${response.requestOptions.uri}
      Status: ${response.statusCode} - ${response.statusMessage}
      Redirect: ${response.isRedirect ? response.realUri : null}
      Response body: ${response.toString()}
    ''');
  }

  static void logError(DioException err) {
    Log.e('''
      ERR - [${err.requestOptions.method}] ${err.requestOptions.uri}
      Status: ${err.response?.statusCode} - ${err.response?.statusMessage}
      Error body: ${err.response.toString()}
    ''');
  }

  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    logRequest(options);
    super.onRequest(options, handler);
  }

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    logResponse(response);
    super.onResponse(response, handler);
  }

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) {
    logError(err);
    super.onError(err, handler);
  }
}
