import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../../../domain/models/address/ward.dart';

part 'ward_response.freezed.dart';
part 'ward_response.g.dart';

@freezed
abstract class WardResponse with _$WardResponse {
  const WardResponse._();
  const factory WardResponse({
    required String code,
    required String name,
    required String fullName,
    required String type,
    required String provinceCode,
  }) = _WardResponse;

  factory WardResponse.fromJson(Map<String, Object?> json) =>
      _$WardResponseFromJson(json);

  WardModel toModel() {
    return WardModel(
      code: code,
      name: name,
      fullName: fullName,
      type: WardTypes.values.byName(type),
      provinceCode: provinceCode,
    );
  }
}
