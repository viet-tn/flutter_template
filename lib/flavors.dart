import 'package:flutter/widgets.dart';

import 'utils/extensions/build_context_extension.dart';

enum Flavor { dev, stag, prod }

abstract class F {
  static late final Flavor appFlavor;

  static String get name => appFlavor.name;

  static String title(BuildContext context) {
    return context.l10n.flavorPrefixTag(appFlavor.name) + context.l10n.title;
  }
}
