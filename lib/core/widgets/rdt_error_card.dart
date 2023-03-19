import 'package:flutter/material.dart';

import '../constants/constants.dart';

class RDTErrorCard extends StatelessWidget {
  final String message;

  const RDTErrorCard({
    super.key,
    this.message = kDefaultErrorMsg,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      padding: const EdgeInsets.all(20),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const Icon(
            Icons.error,
            size: 30,
            color: Colors.red,
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
