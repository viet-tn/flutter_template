import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';

import '../../../l10n/l10n.dart';

final currencyFormatterProvider = Provider.autoDispose<NumberFormat>((ref) {
  final locale = ref.watch(appLocaleProvider).toString();
  return NumberFormat('#,##0', locale);
});
