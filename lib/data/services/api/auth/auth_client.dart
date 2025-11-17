import 'package:dio/dio.dart' hide LogInterceptor;
import 'package:fpdart/fpdart.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../../domain/models/app_exception/app_error.dart';
import '../../../../utils/extensions/dio_extension.dart';
import '../../../../utils/extensions/exception_extension.dart';
import '../base/http_client.dart';
import '../models/auth/login_request.dart';
import '../models/auth/sign_up_request.dart';
import '../api_route.dart';
import '../models/auth/login_response.dart';

part 'auth_client.g.dart';

@Riverpod(dependencies: [httpClient])
AuthClient authClient(Ref ref) {
  final httpClient = ref.watch(httpClientProvider);
  return AuthClient(httpClient);
}

class AuthClient {
  const AuthClient(this._client);

  final Dio _client;

  // TODO: handle response
  TaskEither<AppError, Unit> signUp(SignUpRequest req) {
    return TaskEither.tryCatch(() async {
      final res = await _client.post(ApiRoute.signUp, data: req.toJson());
      res.checkDataType<Map<String, dynamic>>();
      return unit;
    }, (error, stackTrace) => error.toAppError(stackTrace));
  }

  TaskEither<AppError, LoginResponse> loginWithEmailAndPassword(
    LoginRequest req,
  ) {
    return TaskEither.tryCatch(() async {
      final res = await _client.post(
        ApiRoute.loginWithEmailAndPassword,
        data: req.toJson(),
      );
      final data = res.checkDataType<Map<String, dynamic>>();
      return LoginResponse.fromJson(data);
    }, (error, stackTrace) => error.toAppError(stackTrace));
  }
}
