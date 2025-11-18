import 'package:fpdart/fpdart.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../domain/models/app_exception/app_error.dart';
import '../../../domain/models/auth/token_model.dart';
import '../../../utils/extensions/fpdart_extension.dart';
import '../../services/api/token/token_client.dart';
import '../../services/local/secure_storage_service.dart';
import 'token_repository.dart';

part 'token_repository_impl.g.dart';

@Riverpod(keepAlive: true)
TokenRepository tokenRepository(Ref ref) {
  final client = ref.watch(tokenClientProvider);
  final storage = ref.watch(secureStorageServiceProvider);
  return TokenRepositoryImpl(client, storage);
}

class TokenRepositoryImpl implements TokenRepository {
  const TokenRepositoryImpl(this._client, this._storage);

  static const _tokenKey = 'TOKEN';

  final TokenClient _client;
  final SecureStorageService _storage;

  @override
  TaskEither<AppError, Option<TokenModel>> getUsableToken() {
    return _getToken().flatMap(
      (maybeToken) => maybeToken.fold(() => TaskEither.right(none()), (t) {
        if (!t.isAccessTokenExpired) {
          return TaskEither.right(some(t));
        }
        if (t.isRefreshTokenExpired) {
          return deleteToken().map((_) => none());
        }
        return _client
            .refreshAccessTokenGuarded(t.refreshToken)
            .flatMap(
              (res) => _updateAccessToken(
                res.accessToken,
                res.accessTokenExpiresAt,
              ).map((newT) => some(newT)),
            );
      }),
    );
  }

  @override
  TaskEither<AppError, Unit> setToken(TokenModel token) {
    return token.toJson().jsonEncodeSafe().toTaskEither().flatMap(
      (str) => _storage.write(_tokenKey, str),
    );
  }

  @override
  TaskEither<AppError, Unit> deleteToken() {
    return _storage.delete(_tokenKey);
  }

  TaskEither<AppError, Option<TokenModel>> _getToken() {
    return _storage
        .read(_tokenKey)
        .flatMap(
          (maybeString) => maybeString.fold(
            () => TaskEither.right(none()),
            (str) => str
                .jsonDecodeSafe()
                .map((json) => TokenModel.fromJson(json))
                .map((token) => some(token))
                .toTaskEither(),
          ),
        );
  }

  TaskEither<AppError, TokenModel> _updateAccessToken(
    String accessToken,
    String expiresAt,
  ) {
    return _getToken().flatMap(
      (maybeToken) => maybeToken.fold(
        () => TaskEither.left(
          const AppError.database(
            code: AppErrorCode.databaseNotFound,
            message: 'no token found to update access token',
          ),
        ),
        (token) {
          return expiresAt.toDateTimeSafe().toTaskEither().flatMap((parsed) {
            final newToken = token.copyWith(
              accessToken: accessToken,
              accessTokenExpiresAt: parsed,
            );
            return setToken(newToken).map((_) => newToken);
          });
        },
      ),
    );
  }
}
