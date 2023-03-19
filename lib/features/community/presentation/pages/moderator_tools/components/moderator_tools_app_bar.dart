import 'package:flutter/material.dart';

class ModeratorToolsAppBar extends StatelessWidget {
  const ModeratorToolsAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: const Text('Mod tools'),
      centerTitle: true,
    );
  }
}
