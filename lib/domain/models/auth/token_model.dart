import 'package:freezed_annotation/freezed_annotation.dart';

part 'token_model.freezed.dart';
part 'token_model.g.dart';

@freezed
abstract class TokenModel with _$TokenModel {
  const TokenModel._();
  const factory TokenModel({
    required String accessToken,
    required DateTime accessTokenExpiresAt,
    required String refreshToken,
    required DateTime refreshTokenExpiresAt,
  }) = _TokenModel;

  bool get isAccessTokenExpired => DateTime.now().isAfter(accessTokenExpiresAt);
  bool get isRefreshTokenExpired =>
      DateTime.now().isAfter(refreshTokenExpiresAt);

  factory TokenModel.fromJson(Map<String, Object?> json) =>
      _$TokenModelFromJson(json);
}
