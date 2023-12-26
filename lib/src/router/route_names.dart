import '../utils/extensions/list.dart';

enum RouteNames {
  home('/'),
  settings('/settings'),
  profile('/profile');

  // ignore: unused_element
  const RouteNames(this.path, [this.paramName]);

  final String path;
  final String? paramName;

  String get name => path;

  String get subPath => switch (path) {
        '/' => path,
        _ => path.replaceFirst('/', ''),
      };

  String get pathWithParam => '$path/:${paramName!}';
  String get subPathWithParam => '$subPath/:${paramName!}';

  static RouteNames? fromLocation(String location) {
    return RouteNames.values
        .firstWhereOrNull((element) => element.path == location);
  }
}
