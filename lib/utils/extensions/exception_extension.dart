import 'dart:io';
import 'package:dio/dio.dart';
import 'package:stack_trace/stack_trace.dart';

import '../../domain/models/app_exception/app_error.dart';

extension DioErrorExtension on DioException {
  AppError toAppError() {
    final st = Trace.from(stackTrace).terse;
    switch (type) {
      case DioExceptionType.connectionTimeout:
      case DioExceptionType.sendTimeout:
      case DioExceptionType.receiveTimeout:
        return AppError.timeout(originalError: this, stackTrace: st);

      case DioExceptionType.badResponse:
        final statusCode = response?.statusCode;
        if (statusCode == 401) {
          return AppError.unauthorized(originalError: this, stackTrace: st);
        } else if (statusCode == 403) {
          return AppError.api(
            code: AppErrorCode.apiForbidden,
            message: 'Access forbidden',
            statusCode: statusCode,
            originalError: this,
            stackTrace: st,
          );
        } else if (statusCode == 404) {
          return AppError.api(
            code: AppErrorCode.apiNotFound,
            message: 'Resource not found',
            statusCode: statusCode,
            originalError: this,
            stackTrace: st,
          );
        } else if (statusCode != null && statusCode >= 500) {
          return AppError.api(
            code: AppErrorCode.apiServerError,
            message: 'Server error',
            statusCode: statusCode,
            originalError: this,
            stackTrace: st,
          );
        }
        return AppError.api(
          code: AppErrorCode.apiServerError,
          message: message,
          statusCode: statusCode,
          originalError: this,
          stackTrace: st,
        );

      case DioExceptionType.cancel:
        return AppError.cancelled();

      case DioExceptionType.connectionError:
        return AppError.api(
          code: AppErrorCode.apiConnection,
          message: 'No internet connection',
          originalError: this,
          stackTrace: st,
        );

      default:
        return AppError.unknown(
          message: message,
          originalError: this,
          stackTrace: st,
        );
    }
  }
}

extension FormatExceptionExtension on FormatException {
  AppError toAppError() {
    return AppError.parse(
      message: message,
      originalError: this,
      stackTrace: Trace.current(),
    );
  }
}

extension TypeErrorExtension on TypeError {
  AppError toAppError() {
    return AppError.parse(
      message: toString(),
      originalError: this,
      stackTrace: stackTrace,
    );
  }
}

extension SocketExceptionExtension on SocketException {
  AppError toAppError() {
    return AppError.api(
      code: AppErrorCode.apiConnection,
      message: 'Network connection failed',
      originalError: this,
      stackTrace: Trace.current(),
    );
  }
}

extension ExceptionExtension on Object {
  AppError toAppError() {
    if (this is DioException) {
      return (this as DioException).toAppError();
    } else if (this is FormatException) {
      return (this as FormatException).toAppError();
    } else if (this is SocketException) {
      return (this as SocketException).toAppError();
    } else if (this is AppError) {
      return this as AppError;
    }

    return AppError.unknown(
      message: toString(),
      originalError: this,
      stackTrace: Trace.current(),
    );
  }

  AppError orAppError(AppError appError) {
    if (this is AppError) {
      return this as AppError;
    }
    return appError;
  }
}
