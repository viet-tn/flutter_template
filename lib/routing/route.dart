enum XRoute {
  login('/login'),
  signUp('/sign-up'),
  home('/'),
  welcome('/welcome'),
  createComplex('/complex/create'),
  settings('/settings');

  const XRoute(this.path);

  final String path;

  static List<XRoute> get _noAuthRoutes => [XRoute.login, XRoute.signUp];

  static List<String> noAuthRoutePaths() {
    return _noAuthRoutes.map((element) => element.path).toList();
  }
}
