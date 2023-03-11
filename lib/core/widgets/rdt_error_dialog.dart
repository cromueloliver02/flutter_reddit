import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class RDTErrorDialog extends StatelessWidget {
  final String message;

  const RDTErrorDialog({
    super.key,
    required this.message,
  });

  @override
  Widget build(BuildContext context) {
    return CupertinoAlertDialog(
      title: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: const [
          Icon(
            Icons.error,
            color: Colors.red,
          ),
          SizedBox(width: 10),
          Text('Something went wrong'),
        ],
      ),
      content: Padding(
        padding: const EdgeInsets.only(top: 10),
        child: Text(message),
      ),
      actions: [
        CupertinoDialogAction(
          onPressed: () => Navigator.pop(context),
          child: const Text('Okay'),
        ),
      ],
    );
  }
}
