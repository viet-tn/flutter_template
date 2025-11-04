abstract class ApiRoute {
  static const signUp = '/users';
  static const loginWithEmailAndPassword = '/auth/login';
  static const refreshToken = '/auth/refresh';

  static const me = '/me';

  // addresses
  static const provinces = '/address/provinces';
  static String wards(String provinceCode) => '$provinces/$provinceCode/wards';
}
