import 'package:dio/dio.dart';
import 'package:fpdart/fpdart.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../../domain/models/app_exception/app_error.dart';
import '../../../../utils/extensions/dio_extension.dart';
import '../../../../utils/extensions/exception_extension.dart';
import '../api_route.dart';
import '../base/http_client.dart';
import '../models/user/user_response.dart';

part 'profile_client.g.dart';

@Riverpod(dependencies: [httpClient])
ProfileClient profileClient(Ref ref) {
  final httpClient = ref.watch(httpClientProvider);
  return ProfileClient(httpClient);
}

class ProfileClient {
  const ProfileClient(this._client);

  final Dio _client;

  TaskEither<AppError, UserResponse> getMe() {
    return TaskEither.tryCatch(() async {
      final res = await _client.get(ApiRoute.me);
      final data = res.checkDataType<Map<String, dynamic>>();
      return UserResponse.fromJson(data);
    }, (error, stackTrace) => error.toAppError(stackTrace));
  }
}
