import 'package:flutter/material.dart';

class EditCommunityAppBar extends StatelessWidget {
  const EditCommunityAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: const Text('Edit Community'),
      centerTitle: false,
      actions: [
        TextButton(
          onPressed: () {},
          child: const Text('Save'),
        ),
      ],
    );
  }
}
