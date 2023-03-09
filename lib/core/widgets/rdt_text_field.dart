import 'package:flutter/material.dart';

class RDTTextField extends StatelessWidget {
  final String hintText;
  final int? maxLength;
  final TextEditingController? controller;

  const RDTTextField({
    super.key,
    required this.hintText,
    this.maxLength,
    this.controller,
  });

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
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
