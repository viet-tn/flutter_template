import 'package:flutter/widgets.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';

extension FormBuilderExtension on GlobalKey<FormBuilderState> {
  void set({required String keyField, required String value}) {
    currentState!.fields[keyField]!.didChange(value);
  }
}
