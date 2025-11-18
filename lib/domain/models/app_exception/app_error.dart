import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:stack_trace/stack_trace.dart';

part 'app_error.freezed.dart';

enum AppErrorCode {
  // API errors
  apiConnection,
  apiTimeout,
  apiUnauthorized,
  apiForbidden,
  apiNotFound,
  apiServerError,
  apiWrongResponse,

  // Database errors
  databaseOperation,
  databaseRead,
  databaseWrite,
  databaseUpdate,
  databaseDelete,
  databaseNotFound,
  databaseConstraint,

  // Parse errors
  parseFailed,

  // Serialization errors
  encodingFailed,
  decodingFailed,

  // Business logic errors
  validationFailed,
  operationNotAllowed,

  // General errors
  unknown,
  cancelled,
}

@freezed
sealed class AppError with _$AppError {
  const AppError._();

  // Network errors
  const factory AppError.api({
    required AppErrorCode code,
    String? message,
    int? statusCode,
    String? responseBody,
    Object? originalError,
    Trace? stackTrace,
  }) = ApiError;

  const factory AppError.unauthorized({
    @Default(AppErrorCode.apiUnauthorized) AppErrorCode code,
    @Default('Unauthorized access') String? message,
    Object? originalError,
    Trace? stackTrace,
  }) = UnauthorizedError;

  const factory AppError.timeout({
    @Default(AppErrorCode.apiTimeout) AppErrorCode code,
    @Default('Request timeout') String? message,
    Object? originalError,
    Trace? stackTrace,
  }) = TimeoutError;

  // Database errors
  const factory AppError.database({
    required AppErrorCode code,
    String? message,
    Object? originalError,
    Trace? stackTrace,
  }) = DatabaseError;

  // Parse errors
  const factory AppError.parse({
    @Default(AppErrorCode.parseFailed) AppErrorCode code,
    required Object? data,
    String? message,
    Object? originalError,
    Trace? stackTrace,
  }) = ParseError;

  // Encoding errors
  const factory AppError.encoding({
    @Default(AppErrorCode.encodingFailed) AppErrorCode code,
    required Object? data,
    String? message,
    Object? originalError,
    Trace? stackTrace,
  }) = EncodingError;

  // Decoding errors
  const factory AppError.decoding({
    @Default(AppErrorCode.decodingFailed) AppErrorCode code,
    required Object? data,
    String? message,
    Object? originalError,
    Trace? stackTrace,
  }) = DecodingError;

  // Validation errors
  const factory AppError.validation({
    @Default(AppErrorCode.validationFailed) AppErrorCode code,
    required String message,
    @Default({}) Map<String, String> fieldErrors,
    Object? originalError,
    Trace? stackTrace,
  }) = ValidationError;

  // Unknown/Generic errors
  const factory AppError.unknown({
    @Default(AppErrorCode.unknown) AppErrorCode code,
    String? message,
    Object? originalError,
    Trace? stackTrace,
  }) = UnknownError;

  // Cancelled operation
  const factory AppError.cancelled({
    @Default(AppErrorCode.cancelled) AppErrorCode code,
    @Default('Operation cancelled') String? message,
    Object? originalError,
    Trace? stackTrace,
  }) = CancelledError;

  String get technicalDetails {
    return switch (this) {
      ApiError(
        code: var code,
        statusCode: var statusCode,
        message: var message,
        originalError: var originalError,
      ) =>
        'Network Error [$code]${statusCode != null ? ' (Status: $statusCode)' : ''}: $message\nOriginal: $originalError',
      UnauthorizedError(
        code: var code,
        message: var message,
        originalError: var originalError,
      ) =>
        'Auth Error [$code]: $message\nOriginal: $originalError',
      TimeoutError(
        code: var code,
        message: var message,
        originalError: var originalError,
      ) =>
        'Timeout Error [$code]: $message\nOriginal: $originalError',
      DatabaseError(
        code: var code,
        message: var message,
        originalError: var originalError,
      ) =>
        'Database Error [$code]: $message\nOriginal: $originalError',
      ParseError(
        code: var code,
        message: var message,
        originalError: var originalError,
      ) =>
        'Parse Error [$code]: $message\nOriginal: $originalError',
      EncodingError(
        code: var code,
        data: var data,
        message: var message,
        originalError: var originalError,
      ) =>
        'Encoding Error [$code]${' (Data: $data)'}: $message\nOriginal: $originalError',
      DecodingError(
        code: var code,
        data: var data,
        message: var message,
        originalError: var originalError,
      ) =>
        'Decoding Error [$code]${' (Data: $data)'}: $message\nOriginal: $originalError',
      ValidationError(
        code: var code,
        fieldErrors: var fieldErrors,
        message: var message,
      ) =>
        'Validation Error [$code]: $message\nFields: ${fieldErrors.entries.map((e) => '${e.key}: ${e.value}').join(', ')}',
      UnknownError(code: var code, originalError: var originalError) =>
        'Unknown Error [$code]: $message\nOriginal: $originalError',
      CancelledError(code: var code, message: var message) =>
        'Cancelled [$code]: $message',
    };
  }

  bool get isRetryable {
    return switch (this) {
      ApiError(code: var code) =>
        code == AppErrorCode.apiTimeout || code == AppErrorCode.apiConnection,
      TimeoutError() => true,
      _ => false,
    };
  }

  bool get requiresAuth {
    return switch (this) {
      UnauthorizedError() => true,
      _ => false,
    };
  }

  @override
  String toString() {
    return 'AppError: $technicalDetails';
  }
}
