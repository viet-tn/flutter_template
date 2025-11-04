import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../../../domain/models/address/province.dart';

part 'province_response.freezed.dart';
part 'province_response.g.dart';

@freezed
abstract class ProvinceResponse with _$ProvinceResponse {
  const ProvinceResponse._();
  const factory ProvinceResponse({
    required String code,
    required String name,
    required String fullName,
    required String type,
  }) = _ProvinceResponse;

  factory ProvinceResponse.fromJson(Map<String, Object?> json) =>
      _$ProvinceResponseFromJson(json);

  ProvinceModel toModel() {
    return ProvinceModel(
      code: code,
      name: name,
      type: ProvinceTypes.values.byName(type),
    );
  }
}
