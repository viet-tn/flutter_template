import 'package:fpdart/fpdart.dart';

import '../../../domain/models/app_exception/app_error.dart';
import '../../../domain/models/user/user.dart';

abstract class ProfileRepository {
  TaskEither<AppError, UserModel> getMe();
}
