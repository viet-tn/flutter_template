import 'package:flex_color_scheme/flex_color_scheme.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'colors.dart';

abstract class AppTheme {
  static final _fontFamily = GoogleFonts.openSans().fontFamily;
  static final _textTheme = GoogleFonts.openSansTextTheme();

  static ThemeData get light => FlexThemeData.light(
    colorScheme: AppColors.lightColorScheme,
    useMaterial3: true,
    useMaterial3ErrorColors: true,
    fontFamily: _fontFamily,
    subThemesData: _subThemesData,
    textTheme: _textTheme,
  );

  static ThemeData get dark => FlexThemeData.dark(
    colorScheme: AppColors.darkColorScheme,
    useMaterial3: true,
    useMaterial3ErrorColors: true,
    fontFamily: _fontFamily,
    subThemesData: _subThemesData,
    textTheme: _textTheme,
  );

  static FlexSubThemesData get _subThemesData => const FlexSubThemesData(
    interactionEffects: true,
    inputDecoratorIsFilled: false,
    inputDecoratorBorderType: FlexInputBorderType.underline,
    appBarBackgroundSchemeColor: SchemeColor.transparent,
  );
}
