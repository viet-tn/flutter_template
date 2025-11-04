import 'package:freezed_annotation/freezed_annotation.dart';

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

  // Parse/Serialization errors
  parseJson,
  parseInvalidData,

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
    StackTrace? stackTrace,
  }) = ApiError;

  const factory AppError.unauthorized({
    @Default(AppErrorCode.apiUnauthorized) AppErrorCode code,
    @Default('Unauthorized access') String? message,
    Object? originalError,
    StackTrace? stackTrace,
  }) = UnauthorizedError;

  const factory AppError.timeout({
    @Default(AppErrorCode.apiTimeout) AppErrorCode code,
    @Default('Request timeout') String? message,
    Object? originalError,
    StackTrace? stackTrace,
  }) = TimeoutError;

  // Database errors
  const factory AppError.database({
    required AppErrorCode code,
    String? message,
    Object? originalError,
    StackTrace? stackTrace,
  }) = DatabaseError;

  // Parse errors
  const factory AppError.parse({
    @Default(AppErrorCode.parseJson) AppErrorCode code,
    String? message,
    String? fieldName,
    Object? originalError,
    StackTrace? stackTrace,
  }) = ParseError;

  // Validation errors
  const factory AppError.validation({
    @Default(AppErrorCode.validationFailed) AppErrorCode code,
    required String message,
    @Default({}) Map<String, String> fieldErrors,
    Object? originalError,
    StackTrace? stackTrace,
  }) = ValidationError;

  // Unknown/Generic errors
  const factory AppError.unknown({
    @Default(AppErrorCode.unknown) AppErrorCode code,
    String? message,
    Object? originalError,
    StackTrace? stackTrace,
  }) = UnknownError;

  // Cancelled operation
  const factory AppError.cancelled({
    @Default(AppErrorCode.cancelled) AppErrorCode code,
    @Default('Operation cancelled') String? message,
    Object? originalError,
    StackTrace? stackTrace,
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
        fieldName: var fieldName,
        message: var message,
        originalError: var originalError,
      ) =>
        'Parse Error [$code]${fieldName != null ? ' (Field: $fieldName)' : ''}: $message\nOriginal: $originalError',
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
