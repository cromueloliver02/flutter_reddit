import 'package:flutter/material.dart';

class EditUserAppBar extends StatelessWidget {
  const EditUserAppBar({super.key});

  void _save(BuildContext ctx) {}

  @override
  Widget build(BuildContext context) {
    return AppBar(
      centerTitle: false,
      title: const Text('Edit Profile'),
      actions: [
        TextButton(
          onPressed: () => _save(context),
          child: const Text('Save'),
        ),
      ],
    );
  }
}
