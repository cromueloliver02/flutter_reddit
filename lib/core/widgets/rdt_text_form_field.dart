import 'package:flutter/material.dart';

class RDTTextFormField extends StatelessWidget {
  final String hintText;
  final bool enabled;
  final int? maxLength;
  final TextEditingController? controller;
  final String? Function(String?)? validator;
  final void Function(String)? onChanged;

  const RDTTextFormField({
    super.key,
    required this.hintText,
    this.enabled = true,
    this.maxLength,
    this.controller,
    this.validator,
    this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      enabled: enabled,
      maxLength: maxLength,
      decoration: InputDecoration(
        hintText: hintText,
        filled: true,
        border: InputBorder.none,
        contentPadding: const EdgeInsets.all(18),
      ),
      validator: validator,
      onChanged: onChanged,
    );
  }
}
