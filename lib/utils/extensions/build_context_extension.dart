import 'package:flutter/material.dart';

import '../../ui/core/localization/app_localizations.dart';

extension BuildContextExt on BuildContext {
  TextTheme get text => Theme.of(this).textTheme;
  ColorScheme get color => Theme.of(this).colorScheme;
  double get height => MediaQuery.sizeOf(this).height;
  double get width => MediaQuery.sizeOf(this).width;

  AppLocalizations get l10n => AppLocalizations.of(this);
}
