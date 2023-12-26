import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class XStyles {
  static TextStyle? ebGaramond(BuildContext context) =>
      Theme.of(context).textTheme.displayMedium?.copyWith(
            fontFamily: GoogleFonts.ebGaramond().fontFamily,
          );
}
