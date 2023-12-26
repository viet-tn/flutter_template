import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'logger.dart';

class ProviderLogger extends ProviderObserver {
  @override
  void didAddProvider(
    ProviderBase<dynamic> provider,
    Object? value,
    ProviderContainer container,
  ) {
    log.d('Init: ${provider.runtimeType}');
    super.didAddProvider(provider, value, container);
  }

  @override
  void didDisposeProvider(
    ProviderBase<dynamic> provider,
    ProviderContainer container,
  ) {
    log.d('Dispose: ${provider.runtimeType}');
    super.didDisposeProvider(provider, container);
  }

  @override
  void didUpdateProvider(
    ProviderBase<dynamic> provider,
    Object? previousValue,
    Object? newValue,
    ProviderContainer container,
  ) {
    log.d(
      'Update: ${provider.runtimeType}\n'
      'Previous: $previousValue\n'
      'New: $newValue',
    );
    super.didUpdateProvider(provider, previousValue, newValue, container);
  }
}
