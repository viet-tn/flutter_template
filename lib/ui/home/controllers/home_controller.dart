import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../data/repositories/profile/profile_repository.dart';
import '../../../data/repositories/profile/profile_repository_impl.dart';
import '../../../domain/models/user/user.dart';

part 'home_controller.g.dart';

@Riverpod(dependencies: [profileRepository])
class HomeController extends _$HomeController {
  late final ProfileRepository _profileRepo = ref.watch(
    profileRepositoryProvider,
  );

  @override
  Future<UserModel> build() async {
    final result = await _profileRepo.getMe().run();
    return result.match((l) => throw l, (r) => r);
  }
}
