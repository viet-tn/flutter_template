import 'package:fpdart/fpdart.dart';

import '../../../domain/models/app_exception/app_error.dart';
import '../../services/api/models/auth/login_request.dart';
import '../../services/api/models/auth/sign_up_request.dart';

enum AuthStatus { unknown, unauthenticated, authenticated, expired }

abstract class AuthRepository {
  TaskEither<AppError, Unit> signUp(SignUpRequest req);
  TaskEither<AppError, Unit> loginWithEmailAndPassword(LoginRequest req);
  TaskEither<AppError, Unit> loginWithGoogle();
  TaskEither<AppError, Unit> loginWithZalo();
  TaskEither<AppError, Unit> logout();
}
