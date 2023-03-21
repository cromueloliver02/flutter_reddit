import 'package:flutter/material.dart';

class SearchMessageCard extends StatelessWidget {
  final String message;

  const SearchMessageCard({
    super.key,
    required this.message,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Icon(Icons.info, size: 30),
          const SizedBox(height: 20),
          Text(message),
        ],
      ),
    );
  }
}
