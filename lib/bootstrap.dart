import 'dart:async';

import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'data/services/local/shared_preferences_service.dart';
import 'utils/loggers/state_logger.dart';

const kLocale = 'vi_VN';
Future<void> bootstrap(FutureOr<Widget> Function() builder) async {
  WidgetsFlutterBinding.ensureInitialized();
  final prefs = await SharedPreferencesWithCache.create(
    cacheOptions: const SharedPreferencesWithCacheOptions(),
  );

  Intl.defaultLocale = kLocale;
  await initializeDateFormatting(kLocale, null);
  runApp(
    ProviderScope(
      overrides: [sharedPreferencesWithCacheProvider.overrideWithValue(prefs)],
      observers: [StateLogger()],
      child: await builder(),
    ),
  );
}
