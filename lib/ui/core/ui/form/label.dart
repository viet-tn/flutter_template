import 'package:flutter/material.dart';

class XLabel extends StatelessWidget {
  const XLabel({super.key, required this.label, this.isRequired = true});

  final String label;
  final bool isRequired;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text(label),
        if (isRequired) const Text(' *', style: TextStyle(color: Colors.red)),
      ],
    );
  }
}
