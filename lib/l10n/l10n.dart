import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../src/router/app_router.dart';

export 'package:flutter_gen/gen_l10n/app_localizations.dart';

export 'app_localization.dart';

class L10n {
  const L10n._();
  static AppLocalizations get text => AppLocalizations.of(AppRouter.context!);
}
