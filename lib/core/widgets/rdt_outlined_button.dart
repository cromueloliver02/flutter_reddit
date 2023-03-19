import 'package:flutter/material.dart';

class RDTOutlinedButton extends StatelessWidget {
  final String title;
  final VoidCallback? onPressed;

  const RDTOutlinedButton({
    super.key,
    required this.title,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return OutlinedButton(
      onPressed: onPressed,
      style: OutlinedButton.styleFrom(
        padding: const EdgeInsets.symmetric(horizontal: 25),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
      ),
      child: Text(
        title,
        style: Theme.of(context).textTheme.bodyMedium!.copyWith(
              color: Colors.blue,
            ),
      ),
    );
  }
}
