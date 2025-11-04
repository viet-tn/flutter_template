import 'dart:async';
import 'dart:io' show HttpHeaders;

import 'package:dio/dio.dart';
import 'package:fpdart/fpdart.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../../domain/models/app_exception/app_error.dart';
import '../../../../utils/extensions/dio_extension.dart';
import '../../../../utils/extensions/exception_extension.dart';
import '../api_route.dart';
import '../base/http_client.dart';
import '../models/auth/refresh_token_response.dart';

part 'token_client.g.dart';

Completer<Either<AppError, RefreshTokenResponse>>? _refreshing;

@Riverpod(dependencies: [tokenHttpClient])
TokenClient tokenClient(Ref ref) {
  final httpClient = ref.watch(tokenHttpClientProvider);
  return TokenClient(httpClient);
}

class TokenClient {
  const TokenClient(this._client);

  final Dio _client;

  TaskEither<AppError, RefreshTokenResponse> refreshAccessTokenGuarded(
    String refreshToken,
  ) {
    // If a refresh is already in progress, await the same result
    if (_refreshing != null) {
      return TaskEither(() async => _refreshing!.future);
    }

    _refreshing = Completer<Either<AppError, RefreshTokenResponse>>();

    final task = _refreshAccessToken(refreshToken);

    return TaskEither(() async {
      try {
        final either = await task.run();
        _refreshing!.complete(either);
        return either;
      } catch (e, st) {
        final error = e.orAppError(
          AppError.api(
            code: AppErrorCode.apiServerError,
            message: 'Token refresh failed',
            originalError: e,
            stackTrace: st,
          ),
        );
        _refreshing!.complete(Left(error));
        return Left(error);
      } finally {
        _refreshing = null;
      }
    });
  }

  TaskEither<AppError, RefreshTokenResponse> _refreshAccessToken(
    String refreshToken,
  ) {
    return TaskEither.tryCatch(() async {
      final res = await _client.post(
        ApiRoute.refreshToken,
        data: {'refresh_token': refreshToken},
        options: Options(headers: {HttpHeaders.authorizationHeader: null}),
      );
      final data = res.checkDataType<Map<String, dynamic>>();
      return RefreshTokenResponse.fromJson(data);
    }, (err, _) => err.toAppError());
  }
}
