import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../../../domain/models/user/user.dart';

part 'user_response.freezed.dart';
part 'user_response.g.dart';

@freezed
abstract class UserResponse with _$UserResponse {
  const UserResponse._();
  const factory UserResponse({
    String? email,
    required String fullName,
    required String createdAt,
  }) = _UserResponse;

  factory UserResponse.fromJson(Map<String, Object?> json) =>
      _$UserResponseFromJson(json);

  UserModel toModel() {
    return UserModel(email: email, fullName: fullName, createdAt: createdAt);
  }
}
