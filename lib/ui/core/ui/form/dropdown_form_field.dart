import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';

import '../../../../utils/extensions/string_extension.dart';
import 'label.dart';

class XDropdownFormField<M> extends StatelessWidget {
  const XDropdownFormField({
    super.key,
    required this.name,
    this.isRequired = true,
    required this.items,
    required this.dropdownEntryBuilder,
    required this.label,
    required this.valueBuilder,
    this.onChanged,
  });

  final String name;
  final bool isRequired;
  final String label;
  final List<M> items;
  final Widget Function(M e) dropdownEntryBuilder;
  final String Function(M e) valueBuilder;
  final void Function(String? e)? onChanged;

  @override
  Widget build(BuildContext context) {
    return FormBuilderDropdown<String>(
      name: name,
      validator: isRequired
          ? FormBuilderValidators.required(errorText: 'Vui lòng chọn $label'.hc)
          : null,
      decoration: InputDecoration(
        label: XLabel(label: label, isRequired: isRequired),
      ),
      items: items
          .map(
            (e) => DropdownMenuItem<String>(
              value: valueBuilder(e),
              child: dropdownEntryBuilder(e),
            ),
          )
          .toList(),
      onChanged: onChanged,
    );
  }
}
