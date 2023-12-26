import 'package:flex_color_scheme/flex_color_scheme.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class XTheme {
  static final _fontFamily = GoogleFonts.montserrat().fontFamily;
  static const _scheme = FlexScheme.flutterDash;
  static final _textTheme = GoogleFonts.montserratTextTheme();

  static ThemeData get light => FlexThemeData.light(
        appBarElevation: 0.5,
        scheme: _scheme,
        useMaterial3: true,
        useMaterial3ErrorColors: true,
        visualDensity: FlexColorScheme.comfortablePlatformDensity,
        fontFamily: _fontFamily,
        subThemesData: subThemesData,
        onSurface: Colors.black87,
        textTheme: _textTheme,
      );

  static ThemeData get dark => FlexThemeData.dark(
        appBarElevation: 0.5,
        scheme: _scheme,
        useMaterial3: true,
        useMaterial3ErrorColors: true,
        visualDensity: FlexColorScheme.comfortablePlatformDensity,
        fontFamily: _fontFamily,
        subThemesData: subThemesData,
        textTheme: _textTheme,
      );

  static FlexSubThemesData get subThemesData => const FlexSubThemesData(
        appBarCenterTitle: true,
        inputDecoratorIsFilled: false,
      );
}
