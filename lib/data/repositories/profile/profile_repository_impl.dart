import 'package:fpdart/fpdart.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../domain/models/app_exception/app_error.dart';
import '../../../domain/models/user/user.dart';
import '../../services/api/profile/profile_client.dart';
import 'profile_repository.dart';

part 'profile_repository_impl.g.dart';

@riverpod
ProfileRepository profileRepository(Ref ref) {
  final client = ref.read(profileClientProvider);
  return ProfileRepositoryImpl(client);
}

class ProfileRepositoryImpl implements ProfileRepository {
  ProfileRepositoryImpl(this._client);
  final ProfileClient _client;

  @override
  TaskEither<AppError, UserModel> getMe() {
    return _client.getMe().map((r) => r.toModel());
  }
}
