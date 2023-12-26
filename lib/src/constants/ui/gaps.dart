import 'package:flutter/material.dart';

class CGaps {
  const CGaps._();

  // * Padding
  static const contentPadding = EdgeInsets.all(10);
  static const input = EdgeInsets.fromLTRB(12, 20, 12, 12);
  static const listTile = EdgeInsets.symmetric(horizontal: screenValue);
  static const screen = EdgeInsets.all(screenValue);
  static const screenHorizontal = EdgeInsets.symmetric(horizontal: screenValue);
  static const screenValue = 20.0;
  static const screenVertical = EdgeInsets.symmetric(vertical: screenValue);

  static const divider = Divider(height: 0);
  static const fieldHeight = SizedBox(height: fieldHeightValue);
  static const fieldWidth = SizedBox(width: fieldWidthValue);
  static const fieldHeightValue = 30.0;
  static const fieldWidthValue = 30.0;
}
