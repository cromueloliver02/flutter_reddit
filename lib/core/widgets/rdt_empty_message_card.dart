import 'package:flutter/material.dart';

import '../constants/constants.dart';

class RDTEmptyMessageCard extends StatelessWidget {
  final String message;

  const RDTEmptyMessageCard({
    super.key,
    this.message = kDefaultEmptyMsg,
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
            Icons.search_off,
            size: 30,
            color: Colors.blueGrey,
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
