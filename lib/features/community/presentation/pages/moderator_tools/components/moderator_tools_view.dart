import 'package:flutter/material.dart';

class ModeratorToolsView extends StatelessWidget {
  const ModeratorToolsView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Mod tools')),
      body: Column(
        children: [
          ListTile(
            title: const Text('Add Moderator'),
            onTap: () {},
          )
        ],
      ),
    );
  }
}
