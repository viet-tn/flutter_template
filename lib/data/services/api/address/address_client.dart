import 'package:dio/dio.dart';
import 'package:fpdart/fpdart.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../../domain/models/app_exception/app_error.dart';
import '../../../../utils/extensions/dio_extension.dart';
import '../../../../utils/extensions/exception_extension.dart';
import '../api_route.dart';
import '../base/http_client.dart';
import '../models/address/province_response.dart';
import '../models/address/ward_response.dart';

part 'address_client.g.dart';

@riverpod
AddressClient addressClient(Ref ref) {
  final httpClient = ref.watch(httpClientProvider);
  return AddressClient(httpClient);
}

class AddressClient {
  const AddressClient(this._client);

  final Dio _client;

  TaskEither<AppError, List<ProvinceResponse>> getProvinceList() {
    return TaskEither.tryCatch(() async {
      final res = await _client.get(ApiRoute.provinces);
      final data = res.checkDataType<List>();
      return data.map((e) => ProvinceResponse.fromJson(e)).toList();
    }, (error, stackTrace) => error.toAppError(stackTrace));
  }

  TaskEither<AppError, List<WardResponse>> getWardList(String provinceCode) {
    return TaskEither.tryCatch(() async {
      final res = await _client.get<List>(ApiRoute.wards(provinceCode));
      final data = res.checkDataType<List>();
      return data.map((e) => WardResponse.fromJson(e)).toList();
    }, (error, stackTrace) => error.toAppError(stackTrace));
  }
}
