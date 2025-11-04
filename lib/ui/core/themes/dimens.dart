import 'package:flutter/material.dart';

abstract final class Dimens {
  const Dimens();

  static const paddingVertical = 32.0;
  static const paddingHorizontal = 16.0;

  static const edgeInsetsScreenSymmetric = EdgeInsets.symmetric(
    vertical: paddingVertical,
    horizontal: paddingHorizontal,
  );
}
