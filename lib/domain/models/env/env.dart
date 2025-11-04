abstract class Env {
  static const String apiBaseUrl = String.fromEnvironment('API_BASE_URL');
  static const String _connectTimeoutString = String.fromEnvironment(
    'CONNECT_TIMEOUT',
  );
  static const String _receiveTimeoutString = String.fromEnvironment(
    'RECEIVE_TIMEOUT',
  );
  static const String _sendTimeoutString = String.fromEnvironment(
    'SEND_TIMEOUT',
  );

  static Duration get connectTimeout =>
      Duration(seconds: int.tryParse(_connectTimeoutString) ?? 10);

  static Duration get receiveTimeout =>
      Duration(seconds: int.tryParse(_receiveTimeoutString) ?? 20);

  static Duration get sendTimeout =>
      Duration(seconds: int.tryParse(_sendTimeoutString) ?? 20);
}
