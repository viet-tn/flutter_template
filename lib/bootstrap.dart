import 'dart:async';

import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'src/utils/logger/provider_logger.dart';

Future<void> bootstrap(FutureOr<Widget> Function() builder) async {
  WidgetsFlutterBinding.ensureInitialized();

  //* Add cross-flavor configuration here

  runApp(
    ProviderScope(
      observers: [
        ProviderLogger(),
      ],
      child: await builder(),
    ),
  );
}
