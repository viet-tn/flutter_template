import 'package:flutter/material.dart';

import 'build_context.dart';

extension TextStyleExtension on TextStyle {
  TextStyle get bold => copyWith(fontWeight: FontWeight.bold);
  TextStyle primaryColor(BuildContext context) =>
      copyWith(color: context.color.primary);
  TextStyle secondaryColor(BuildContext context) =>
      copyWith(color: context.color.secondary);
  TextStyle onPrimaryContainerColor(BuildContext context) =>
      copyWith(color: context.color.onPrimaryContainer);
}
