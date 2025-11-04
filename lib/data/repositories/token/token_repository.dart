import 'package:fpdart/fpdart.dart';

import '../../../domain/models/app_exception/app_error.dart';
import '../../../domain/models/auth/token_model.dart';

abstract class TokenRepository {
  TaskEither<AppError, Option<TokenModel>> getUsableToken();
  TaskEither<AppError, Unit> setToken(TokenModel token);
  TaskEither<AppError, Unit> expireSession();
}
