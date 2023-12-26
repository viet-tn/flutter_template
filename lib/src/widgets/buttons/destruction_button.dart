import 'package:flutter/material.dart';

class DestructionButton extends StatelessWidget {
  const DestructionButton({
    required this.onPressed,
    required this.label,
    super.key,
  });

  final String label;
  final VoidCallback? onPressed;

  @override
  Widget build(BuildContext context) {
    return FilledButton(
      style: FilledButton.styleFrom(
        backgroundColor: Theme.of(context).colorScheme.errorContainer,
      ),
      onPressed: onPressed,
      child: Text(
        label,
        style: Theme.of(context).textTheme.labelLarge?.copyWith(
              color: Theme.of(context).colorScheme.error,
            ),
      ),
    );
  }
}
