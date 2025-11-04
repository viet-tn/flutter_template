import 'dart:convert';

import 'package:fpdart/fpdart.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../domain/models/app_exception/app_error.dart';
import '../../../domain/models/auth/token_model.dart';

part 'shared_preferences_service.g.dart';

@Riverpod(keepAlive: true)
SharedPreferencesWithCache sharedPreferencesWithCache(Ref ref) {
  // Initialize this on app startup then overwrite this provider's value
  throw UnimplementedError();
}

@Riverpod(keepAlive: true, dependencies: [sharedPreferencesWithCache])
SharedPreferencesService sharedPreferencesService(Ref ref) {
  final prefs = ref.watch(sharedPreferencesWithCacheProvider);
  return SharedPreferencesService(prefs);
}

class SharedPreferencesService {
  const SharedPreferencesService(this._pref);

  final SharedPreferencesWithCache _pref;

  static const _tokenKey = 'TOKEN';

  TaskEither<AppError, Unit> _setString(String key, String value) {
    return TaskEither.tryCatch(
      () async {
        await _pref.setString(key, value);
        return unit;
      },
      (e, st) => AppError.database(
        code: AppErrorCode.databaseWrite,
        message: 'failed to set $key key: $e',
        originalError: e,
        stackTrace: st,
      ),
    );
  }

  Option<String> _getString(String key) {
    return Option.fromNullable(_pref.getString(key));
  }

  TaskEither<AppError, Unit> _remove(String key) {
    return TaskEither.tryCatch(
      () async {
        await _pref.remove(key);
        return unit;
      },
      (e, st) => AppError.database(
        code: AppErrorCode.databaseDelete,
        message: 'failed to remove $key key: $e',
        originalError: e,
        stackTrace: st,
      ),
    );
  }

  TaskEither<AppError, Unit> reloadCache() {
    return TaskEither.tryCatch(
      () async {
        await _pref.reloadCache();
        return unit;
      },
      (e, st) => AppError.database(
        code: AppErrorCode.databaseOperation,
        message: 'failed to reload cache: $e',
        originalError: e,
        stackTrace: st,
      ),
    );
  }

  Either<AppError, Option<TokenModel>> getToken() {
    return _getString(_tokenKey).fold(() => const Right(None()), (token) {
      return Either.tryCatch(
        () => Option.of(TokenModel.fromJson(jsonDecode(token))),
        (e, st) => AppError.parse(
          message: 'failed to decode token: $e',
          originalError: e,
          stackTrace: st,
        ),
      );
    });
  }

  TaskEither<AppError, Unit> setToken(TokenModel token) {
    return TaskEither.tryCatch(
      () async => jsonEncode(token.toJson()),
      (e, st) => AppError.parse(
        message: 'failed to encode token: $e',
        originalError: e,
        stackTrace: st,
      ),
    ).flatMap((json) => _setString(_tokenKey, json)).andThen(reloadCache);
  }

  TaskEither<AppError, Unit> removeToken() {
    return _remove(_tokenKey).andThen(reloadCache);
  }

  TaskEither<AppError, TokenModel> updateAccessToken(
    String accessToken,
    String expiresAt,
  ) {
    return TaskEither.fromEither(getToken()).flatMap(
      (maybeToken) => maybeToken.fold(
        () => TaskEither.left(
          AppError.database(
            code: AppErrorCode.databaseNotFound,
            message: 'no token found to update access token',
          ),
        ),
        (token) {
          final parsed = DateTime.tryParse(expiresAt);
          if (parsed == null) {
            return TaskEither.left(
              AppError.parse(message: 'invalid expiresAt format: $expiresAt'),
            );
          }
          final newToken = token.copyWith(
            accessToken: accessToken,
            accessTokenExpiresAt: parsed,
          );
          return setToken(newToken).map((_) => newToken);
        },
      ),
    );
  }
}
