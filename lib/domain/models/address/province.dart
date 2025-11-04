import 'package:freezed_annotation/freezed_annotation.dart';

part 'province.freezed.dart';
part 'province.g.dart';

enum ProvinceTypes { city, province }

@freezed
abstract class ProvinceModel with _$ProvinceModel {
  const factory ProvinceModel({
    required String code,
    required String name,
    required ProvinceTypes type,
  }) = _ProvinceModel;

  factory ProvinceModel.fromJson(Map<String, Object?> json) =>
      _$ProvinceModelFromJson(json);
}
