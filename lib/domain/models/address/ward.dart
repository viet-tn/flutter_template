import 'package:freezed_annotation/freezed_annotation.dart';

part 'ward.freezed.dart';
part 'ward.g.dart';

enum WardTypes { ward, commune, other }

@freezed
abstract class WardModel with _$WardModel {
  const factory WardModel({
    required String code,
    required String name,
    required String fullName,
    required WardTypes type,
    required String provinceCode,
  }) = _WardModel;

  factory WardModel.fromJson(Map<String, Object?> json) =>
      _$WardModelFromJson(json);
}
