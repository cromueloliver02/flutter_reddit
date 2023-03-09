import 'package:flutter/material.dart';

class RDTElevatedButton extends StatelessWidget {
  final String title;
  final VoidCallback? onPressed;
  final bool isBlock;

  const RDTElevatedButton({
    super.key,
    required this.title,
    required this.onPressed,
    this.isBlock = false,
  });

  @override
  Widget build(BuildContext context) {
    final TextTheme textTheme = Theme.of(context).textTheme;

    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        minimumSize: isBlock ? const Size(double.infinity, 50) : null,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
      ),
      child: Text(
        title,
        style: textTheme.bodyLarge,
      ),
    );
  }
}
