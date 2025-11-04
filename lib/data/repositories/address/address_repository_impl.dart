import 'package:fpdart/fpdart.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../domain/models/address/province.dart';
import '../../../domain/models/address/ward.dart';
import '../../../domain/models/app_exception/app_error.dart';
import '../../services/api/address/address_client.dart';
import 'address_repository.dart';

part 'address_repository_impl.g.dart';

@riverpod
AddressRepository addressRepository(Ref ref) {
  final client = ref.read(addressClientProvider);
  return AddressRepositoryImpl(client);
}

class AddressRepositoryImpl implements AddressRepository {
  const AddressRepositoryImpl(this._client);

  final AddressClient _client;

  @override
  TaskEither<AppError, List<ProvinceModel>> getProvinceList() {
    return _client.getProvinceList().map(
      (r) => r.map((e) => e.toModel()).toList(),
    );
  }

  @override
  TaskEither<AppError, List<WardModel>> getWardList(String provinceCode) {
    return _client
        .getWardList(provinceCode)
        .map((r) => r.map((e) => e.toModel()).toList());
  }
}
