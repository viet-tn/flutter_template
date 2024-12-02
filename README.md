# Flutter Template

[![License: MIT][license_badge]][license_link]

---

## Getting Started 🚀

_\*Flutter Template works on iOS, Android, Web, and Windows._

---

## Working with Translations 🌐

This project relies on [flutter_localizations][flutter_localizations_link] and follows the [official internationalization guide for Flutter][internationalization_link].

### Adding Strings

1. To add a new localizable string, open the `app_en.arb` file at `lib/l10n/arb/app_en.arb`.

```arb
{
    "@@locale": "en",
    "appName": "Template App",
    "home": "Home",
    "profile": "Profile",
    "settings": "Settings"
}
```

2. Then add a new key/value and description

```arb
{
    "@@locale": "en",
    "appName": "Template App",
    "home": "Home",
    "profile": "Profile",
    "settings": "Settings",
    "helloWorld": "Hello World",
    "@helloWorld": {
        "description": "Hello World Text"
    }
}
```

3. Use the new string

```dart
import 'package:flutter_template/l10n/l10n.dart';

@override
Widget build(BuildContext context) {
  final l10n = context.l10n;
  return Text(l10n.helloWorld);
}
```

### Adding Supported Locales

Update the `CFBundleLocalizations` array in the `Info.plist` at `ios/Runner/Info.plist` and `macos/Runner/Info.plist` to include the new locale.

```xml
    ...

  <key>CFBundleLocalizations</key>
	<array>
		<string>en</string>
		<string>vi</string>
	</array>

    ...
```

### Adding Translations

1. For each supported locale, add a new ARB file in `lib/l10n/arb`.

```
├── l10n
│   ├── arb
│   │   ├── app_en.arb
│   │   └── app_vi.arb
```

2. Add the translated strings to each `.arb` file:

`app_en.arb`

```arb
{
    "@@locale": "en",
    "appName": "Template App",
    "home": "Home",
    "profile": "Profile",
    "settings": "Settings"
}
```

`app_vi.arb`

```arb
{
    "@@locale": "vi",
    "appName": "Template App",
    "home": "Trang chủ",
    "profile": "Hồ sơ",
    "settings": "Cài đặt"
}
```

### Generating Translations

To use the latest translations changes, you will need to generate them:

1. Generate localizations for the current project:

```sh
flutter gen-l10n --arb-dir="lib/l10n/arb"
```

Alternatively, run `flutter run` and code generation will take place automatically.

[coverage_badge]: coverage_badge.svg
[flutter_localizations_link]: https://api.flutter.dev/flutter/flutter_localizations/flutter_localizations-library.html
[internationalization_link]: https://flutter.dev/docs/development/accessibility-and-localization/internationalization
[license_badge]: https://img.shields.io/badge/license-MIT-blue.svg
[license_link]: https://opensource.org/licenses/MIT