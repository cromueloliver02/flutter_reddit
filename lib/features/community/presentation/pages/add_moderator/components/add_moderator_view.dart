import 'package:flutter/material.dart';

class AddModeratorView extends StatelessWidget {
  const AddModeratorView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add Moderator'),
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.done),
          ),
        ],
      ),
      body: const Center(
        child: Text('ADD MODERATOR PAGE'),
      ),
    );
  }
}
