// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for English (`en`).
class AppLocalizationsEn extends AppLocalizations {
  AppLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String get title => 'Flutter template';

  @override
  String flavorPrefixTag(String flavor) {
    String _temp0 = intl.Intl.selectLogic(flavor, {
      'other': '',
      'dev': '[Dev] ',
      'stag': '[Stag] ',
    });
    return '$_temp0';
  }
}
