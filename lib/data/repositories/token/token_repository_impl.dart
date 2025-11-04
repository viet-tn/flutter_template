import 'package:fpdart/src/option.dart';

import 'package:fpdart/src/task_either.dart';

import 'package:fpdart/src/unit.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../domain/models/app_exception/app_error.dart';
import '../../../domain/models/auth/token_model.dart';
import '../../services/api/token/token_client.dart';
import '../../services/local/shared_preferences_service.dart';
import 'token_repository.dart';

part 'token_repository_impl.g.dart';

@Riverpod(dependencies: [tokenClient, sharedPreferencesService])
TokenRepository tokenRepository(Ref ref) {
  final client = ref.watch(tokenClientProvider);
  final pref = ref.watch(sharedPreferencesServiceProvider);
  return TokenRepositoryImpl(client, pref);
}

class TokenRepositoryImpl implements TokenRepository {
  const TokenRepositoryImpl(this._client, this._pref);

  final TokenClient _client;
  final SharedPreferencesService _pref;

  @override
  TaskEither<AppError, Option<TokenModel>> getUsableToken() {
    return TaskEither.fromEither(_pref.getToken()).flatMap(
      (maybeToken) => maybeToken.fold(() => TaskEither.right(none()), (t) {
        if (!t.isAccessTokenExpired) {
          return TaskEither.right(some(t));
        }
        if (t.isRefreshTokenExpired) {
          return _pref.removeToken().map((_) => none());
        }
        return _client
            .refreshAccessTokenGuarded(t.refreshToken)
            .flatMap(
              (res) => _pref
                  .updateAccessToken(res.accessToken, res.accessTokenExpiresAt)
                  .map((newT) => some(newT)),
            );
      }),
    );
  }

  @override
  TaskEither<AppError, Unit> setToken(TokenModel token) {
    return _pref.setToken(token);
  }

  @override
  TaskEither<AppError, Unit> expireSession() {
    return _pref.removeToken();
  }
}
