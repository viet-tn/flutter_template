import 'package:freezed_annotation/freezed_annotation.dart';

part 'complex_model.freezed.dart';
part 'complex_model.g.dart';

@freezed
abstract class ComplexModel with _$ComplexModel {
  const factory ComplexModel({
    required String id,
    required String name,
    required int billingDayOfMonth,
    required int dueInDays,
    required String provinceCode,
    required String wardCode,
    required String addressLine,
    required DateTime createdAt,
    required DateTime updatedAt,
  }) = _ComplexModel;

  factory ComplexModel.fromJson(Map<String, Object?> json) =>
      _$ComplexModelFromJson(json);
}
