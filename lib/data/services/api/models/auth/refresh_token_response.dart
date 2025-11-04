import 'package:freezed_annotation/freezed_annotation.dart';

part 'refresh_token_response.freezed.dart';
part 'refresh_token_response.g.dart';

@freezed
abstract class RefreshTokenResponse with _$RefreshTokenResponse {
  const factory RefreshTokenResponse({
    required String accessToken,
    required String accessTokenExpiresAt,
  }) = _RefreshTokenResponse;

  factory RefreshTokenResponse.fromJson(Map<String, Object?> json) =>
      _$RefreshTokenResponseFromJson(json);
}
