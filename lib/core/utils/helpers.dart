import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../widgets/widgets.dart';

void showSnackBar(
  BuildContext ctx, {
  required String message,
}) {
  final ScaffoldMessengerState messenger = ScaffoldMessenger.of(ctx);

  messenger.hideCurrentSnackBar();
  messenger.showSnackBar(SnackBar(content: Text(message)));
}

void showErrorDialog(BuildContext ctx, {required String message}) {
  showCupertinoDialog(
    context: ctx,
    barrierDismissible: false,
    builder: (ctx) => RDTErrorDialog(message: message),
  );
}
