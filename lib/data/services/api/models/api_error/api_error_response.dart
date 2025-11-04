import 'package:freezed_annotation/freezed_annotation.dart';

part 'api_error_response.freezed.dart';
part 'api_error_response.g.dart';

@freezed
abstract class ApiErrorResponse with _$ApiErrorResponse {
  const factory ApiErrorResponse({
    required String code,
    required String message,
    required int status,
    String? requestId,
    List<String>? fieldErrors,
  }) = _ApiErrorResponse;

  factory ApiErrorResponse.fromJson(Map<String, Object?> json) =>
      _$ApiErrorResponseFromJson(json);
}
