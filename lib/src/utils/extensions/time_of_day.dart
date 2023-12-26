import 'package:flutter/material.dart';

extension TimeOfDayExtension on TimeOfDay {
  String get formatted =>
      '${hour.toString().padLeft(2, '0')}:${minute.toString().padLeft(2, '0')}';
  DateTime toDateTime() => DateTime(0, 1, 1, hour, minute);
}
