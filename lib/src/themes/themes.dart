import 'package:flex_color_scheme/flex_color_scheme.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class XTheme {
  static final _fontFamily = GoogleFonts.roboto().fontFamily;
  static final _textTheme = GoogleFonts.robotoTextTheme();

  static ThemeData get light => FlexThemeData.light(
        useMaterial3: true,
        useMaterial3ErrorColors: true,
        fontFamily: _fontFamily,
        subThemesData: subThemesData,
        textTheme: _textTheme,
        colors: _lightSchemeColor,
      );

  static ThemeData get dark => FlexThemeData.dark(
        useMaterial3: true,
        useMaterial3ErrorColors: true,
        fontFamily: _fontFamily,
        subThemesData: subThemesData,
        textTheme: _textTheme,
        colors: _darkSchemeColor,
      );

  static FlexSubThemesData get subThemesData => const FlexSubThemesData(
        appBarCenterTitle: true,
        inputDecoratorIsFilled: false,
        outlinedButtonOutlineSchemeColor: SchemeColor.primary,
      );

  static FlexSchemeColor get _lightSchemeColor => const FlexSchemeColor(
        primary: Colors.blue,
        secondary: Colors.cyan,
      );

  static FlexSchemeColor get _darkSchemeColor => const FlexSchemeColor(
        primary: Colors.blue,
        secondary: Colors.cyan,
      );
}
