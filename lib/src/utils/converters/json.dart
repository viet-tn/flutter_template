import 'dart:convert';

import 'package:flutter/foundation.dart';

class JsonMapConverter {
  static Future<String> encodeJson(Object? map) {
    return compute(jsonEncode, map);
  }

  static Future<Map<String, dynamic>> decodeJson(String text) {
    return compute(_parseAndDecode, text);
  }

  static Map<String, Object?> _parseAndDecode(String response) {
    return jsonDecode(response) as Map<String, dynamic>;
  }
}
