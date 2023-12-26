extension StringExtension on String {
  String get raw => this;
  String get toParsableNumber => replaceAll(RegExp(r'[^\d]'), '');
  int? get toPrice => int.tryParse(this);
}
