import 'package:flutter/material.dart';

class RDTTextField extends StatelessWidget {
  final String hintText;
  final bool enabled;
  final int? maxLength;
  final TextEditingController? controller;

  const RDTTextField({
    super.key,
    required this.hintText,
    this.enabled = true,
    this.maxLength,
    this.controller,
  });

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      enabled: enabled,
      maxLength: maxLength,
      decoration: InputDecoration(
        hintText: hintText,
        filled: true,
        border: InputBorder.none,
        contentPadding: const EdgeInsets.all(18),
      ),
    );
  }
}
