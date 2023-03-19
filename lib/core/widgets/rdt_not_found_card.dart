import 'package:flutter/material.dart';

import '../constants/constants.dart';

class RDTNotFoundCard extends StatelessWidget {
  final String message;

  const RDTNotFoundCard({
    super.key,
    this.message = kDefaultNotFoundMsg,
  });

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);

    return Container(
      alignment: Alignment.center,
      padding: const EdgeInsets.all(20),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Icon(
            Icons.search_off,
            size: 30,
            color: theme.primaryColor,
          ),
          const SizedBox(height: 20),
          Text(
            message,
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}
