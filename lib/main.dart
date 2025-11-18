import 'package:flutter/services.dart';

import 'app.dart';
import 'bootstrap.dart';
import 'flavors.dart';

void main() async {
  F.appFlavor = Flavor.values.firstWhere(
    (element) => element.name == appFlavor,
    orElse: () => Flavor.dev,
  );
  await bootstrap(() => const App());
}
