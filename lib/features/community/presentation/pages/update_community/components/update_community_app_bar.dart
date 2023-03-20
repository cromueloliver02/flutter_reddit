import 'package:flutter/material.dart';

class UpdateCommunityAppBar extends StatelessWidget {
  const UpdateCommunityAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: const Text('Update Community'),
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
