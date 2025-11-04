import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'logger.dart';

final class StateLogger extends ProviderObserver {
  @override
  void didUpdateProvider(
    ProviderObserverContext context,
    Object? previousValue,
    Object? newValue,
  ) {
    super.didUpdateProvider(context, previousValue, newValue);
    if (newValue is AsyncError) {
      Log.e('''
        {
          "previousValue": "$previousValue",
          "newValue": "$newValue"
        }''');
      return;
    }
    Log.d('''
      {
        "previousValue": "$previousValue",
        "newValue": "$newValue"
      }''');
  }
}
