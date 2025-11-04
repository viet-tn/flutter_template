import 'package:fpdart/fpdart.dart';

import '../../../domain/models/address/province.dart';
import '../../../domain/models/address/ward.dart';
import '../../../domain/models/app_exception/app_error.dart';

abstract class AddressRepository {
  TaskEither<AppError, List<ProvinceModel>> getProvinceList();
  TaskEither<AppError, List<WardModel>> getWardList(String provinceCode);
}
