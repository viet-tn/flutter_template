import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../../../domain/models/complex/complex_model.dart';

part 'create_complex_response.freezed.dart';
part 'create_complex_response.g.dart';

@freezed
abstract class CreateComplexResponse with _$CreateComplexResponse {
  const CreateComplexResponse._();
  const factory CreateComplexResponse({
    required String id,
    required String landlordId,
    required String name,
    required int billingDayOfMonth,
    required int dueInDays,
    required String provinceCode,
    required String wardCode,
    required String addressLine,
    required String createdAt,
    required String updatedAt,
  }) = _CreateComplexResponse;

  factory CreateComplexResponse.fromJson(Map<String, Object?> json) =>
      _$CreateComplexResponseFromJson(json);

  ComplexModel toModel() {
    return ComplexModel(
      id: id,
      name: name,
      billingDayOfMonth: billingDayOfMonth,
      dueInDays: dueInDays,
      provinceCode: provinceCode,
      wardCode: wardCode,
      addressLine: addressLine,
      createdAt: DateTime.parse(createdAt),
      updatedAt: DateTime.parse(updatedAt),
    );
  }
}
