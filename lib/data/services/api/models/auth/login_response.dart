import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../../../domain/models/auth/token_model.dart';
import '../user/user_response.dart';

part 'login_response.freezed.dart';
part 'login_response.g.dart';

@freezed
abstract class LoginResponse with _$LoginResponse {
  const LoginResponse._();
  const factory LoginResponse({
    required String accessToken,
    required String accessTokenExpiresAt,
    required String refreshToken,
    required String refreshTokenExpiresAt,
    required UserResponse user,
  }) = _LoginResponse;

  factory LoginResponse.fromJson(Map<String, Object?> json) =>
      _$LoginResponseFromJson(json);

  TokenModel toToken() => TokenModel(
    accessToken: accessToken,
    accessTokenExpiresAt: DateTime.parse(accessTokenExpiresAt),
    refreshToken: refreshToken,
    refreshTokenExpiresAt: DateTime.parse(refreshTokenExpiresAt),
  );
}
