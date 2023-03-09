import 'package:flutter/material.dart';

class CreateCommunityAppBar extends StatelessWidget {
  const CreateCommunityAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      centerTitle: true,
      title: const Text('Create a Community'),
    );
  }
}
