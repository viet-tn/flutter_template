import 'package:freezed_annotation/freezed_annotation.dart';

part 'create_complex_request.freezed.dart';
part 'create_complex_request.g.dart';

@freezed
abstract class CreateComplexRequest with _$CreateComplexRequest {
  const factory CreateComplexRequest({
    required String name,
    required int billingDayOfMonth,
    required int dueInDays,
    required String provinceCode,
    required String wardCode,
    required String addressLine,
  }) = _CreateComplexRequest;

  factory CreateComplexRequest.fromJson(Map<String, Object?> json) =>
      _$CreateComplexRequestFromJson(json);
}
