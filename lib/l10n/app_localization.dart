import 'package:flutter/material.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'app_localization.g.dart';

@riverpod
class AppLocale extends _$AppLocale {
  @override
  Locale build() {
    return const Locale('vi', 'VN');
  }

  void onLocaleChanged(Locale locale) {
    state = locale;
  }
}
