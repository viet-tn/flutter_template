import 'package:dio/dio.dart';

import '../../domain/models/app_exception/app_error.dart';

extension DioExtension on Response<dynamic> {
  /// Checks if the response data is of type [T].
  /// Throws an [AppError] if the type does not match.
  T checkDataType<T>() {
    if (data is T) {
      return data as T;
    }
    throw AppError.api(
      code: AppErrorCode.apiWrongResponse,
      message: 'Wrong response format',
      responseBody: data.toString(),
    );
  }

  /// Checks if the request endpoint matches the given [endpoint].
  bool isEndpoint(String endpoint) {
    return requestOptions.uri.path.endsWith(endpoint);
  }
}
