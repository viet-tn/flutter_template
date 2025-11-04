import 'dart:io';

import 'package:dio/dio.dart';

import '../../../../utils/extensions/dio_extension.dart';
import '../../../../utils/loggers/logger.dart';
import '../../../repositories/token/token_repository.dart';
import '../models/auth/login_response.dart';
import '../api_route.dart';

class RefreshTokenInterceptor extends QueuedInterceptor {
  RefreshTokenInterceptor(this._tokenRepo);
  final TokenRepository _tokenRepo;

  @override
  void onRequest(
    RequestOptions options,
    RequestInterceptorHandler handler,
  ) async {
    if (options.path.endsWith(ApiRoute.refreshToken)) {
      return super.onRequest(options, handler);
    }

    final result = await _tokenRepo.getUsableToken().run();
    result.fold(
      (err) {
        handler.reject(
          DioException(
            requestOptions: options,
            type: DioExceptionType.cancel,
            error: err,
          ),
        );
      },
      (maybeToken) {
        maybeToken.match(
          () {},
          (token) => options.headers[HttpHeaders.authorizationHeader] =
              'Bearer ${token.accessToken}',
        );
        return super.onRequest(options, handler);
      },
    );
  }

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) async {
    if (response.statusCode != HttpStatus.ok) {
      return super.onResponse(response, handler);
    }
    // Save token on login
    if (response.isEndpoint(ApiRoute.loginWithEmailAndPassword)) {
      final data = response.checkDataType<Map<String, dynamic>>();
      final loginRes = LoginResponse.fromJson(data);
      final either = await _tokenRepo.setToken(loginRes.toToken()).run();
      either.fold((err) => Log.e(null, err: err), (_) {});
    }
    // Save token on sign up
    if (response.isEndpoint(ApiRoute.signUp)) {
      final data = response.checkDataType<Map<String, dynamic>>();
      final signUpRes = LoginResponse.fromJson(
        data,
      ); // TODO: replace with SignUpResponse
      final either = await _tokenRepo.setToken(signUpRes.toToken()).run();
      either.fold((err) => Log.e(null, err: err), (_) {});
    }

    super.onResponse(response, handler);
  }

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) async {
    if (err.response?.statusCode == HttpStatus.unauthorized) {
      await _tokenRepo.expireSession().run();
    }
    return handler.next(err);
  }
}
