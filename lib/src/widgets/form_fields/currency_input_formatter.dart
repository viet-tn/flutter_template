import 'dart:math';

import 'package:flutter/services.dart';
import 'package:intl/intl.dart';

import '../../utils/extensions/string.dart';

class CurrencyInputFormatter extends TextInputFormatter {
  CurrencyInputFormatter({
    required this.formatter,
  });

  final NumberFormat formatter;
  static const int _maxPrice = 100000000000000;

  @override
  TextEditingValue formatEditUpdate(
    TextEditingValue oldValue,
    TextEditingValue newValue,
  ) {
    if (newValue.text.isEmpty) return TextEditingValue.empty;
    final parsableNumber = newValue.text.toParsableNumber;
    final price = parsableNumber.toPrice;

    if (price == 0 || price == null) {
      return TextEditingValue.empty;
    }

    if (price > _maxPrice) {
      return oldValue;
    }

    final newText = formatter.format(price);

    final isSeparatorAdded =
        parsableNumber.length != 1 && parsableNumber.length % 3 == 1;

    return newValue.copyWith(
      text: newText,
      selection: TextSelection.collapsed(
        offset: min(
          newText.length,
          newValue.selection.baseOffset + (isSeparatorAdded ? 1 : 0),
        ),
      ),
    );
  }
}
