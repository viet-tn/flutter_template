import 'dart:io';
import 'package:dio/dio.dart';
import 'package:stack_trace/stack_trace.dart';

import '../../domain/models/app_exception/app_error.dart';

extension DioErrorExtension on DioException {
  AppError toAppError(Trace stackTrace) {
    switch (type) {
      case DioExceptionType.connectionTimeout:
      case DioExceptionType.sendTimeout:
      case DioExceptionType.receiveTimeout:
        return AppError.timeout(originalError: this, stackTrace: stackTrace);

      case DioExceptionType.badResponse:
        final statusCode = response?.statusCode;
        if (statusCode == 401) {
          return AppError.unauthorized(
            originalError: this,
            stackTrace: stackTrace,
          );
        } else if (statusCode == 403) {
          return AppError.api(
            code: AppErrorCode.apiForbidden,
            message: 'Access forbidden',
            statusCode: statusCode,
            originalError: this,
            stackTrace: stackTrace,
          );
        } else if (statusCode == 404) {
          return AppError.api(
            code: AppErrorCode.apiNotFound,
            message: 'Resource not found',
            statusCode: statusCode,
            originalError: this,
            stackTrace: stackTrace,
          );
        } else if (statusCode != null && statusCode >= 500) {
          return AppError.api(
            code: AppErrorCode.apiServerError,
            message: 'Server error',
            statusCode: statusCode,
            originalError: this,
            stackTrace: stackTrace,
          );
        }
        return AppError.api(
          code: AppErrorCode.apiServerError,
          message: message,
          statusCode: statusCode,
          originalError: this,
          stackTrace: stackTrace,
        );

      case DioExceptionType.cancel:
        return AppError.cancelled();

      case DioExceptionType.connectionError:
        return AppError.api(
          code: AppErrorCode.apiConnection,
          message: 'No internet connection',
          originalError: this,
          stackTrace: stackTrace,
        );

      default:
        return AppError.unknown(
          message: message,
          originalError: this,
          stackTrace: stackTrace,
        );
    }
  }
}

extension FormatExceptionExtension on FormatException {
  AppError toAppError(Trace stackTrace) {
    return AppError.parse(
      data: source,
      message: message,
      originalError: this,
      stackTrace: stackTrace,
    );
  }
}

extension TypeErrorExtension on TypeError {
  AppError toAppError(Trace stackTrace) {
    return AppError.parse(
      data: null,
      message: toString(),
      originalError: this,
      stackTrace: stackTrace,
    );
  }
}

extension SocketExceptionExtension on SocketException {
  AppError toAppError(Trace stackTrace) {
    return AppError.api(
      code: AppErrorCode.apiConnection,
      message: 'Network connection failed',
      originalError: this,
      stackTrace: stackTrace,
    );
  }
}

extension ExceptionExtension on Object {
  AppError toAppError(StackTrace stackTrace) {
    final trace = stackTrace is Trace
        ? stackTrace
        : Trace.from(stackTrace).terse;
    if (this is DioException) {
      return (this as DioException).toAppError(trace);
    } else if (this is FormatException) {
      return (this as FormatException).toAppError(trace);
    } else if (this is SocketException) {
      return (this as SocketException).toAppError(trace);
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
