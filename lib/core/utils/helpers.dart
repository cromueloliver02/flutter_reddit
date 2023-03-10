import 'package:flutter/material.dart';

void showSnackBar(
  BuildContext ctx, {
  required String message,
}) {
  final ScaffoldMessengerState messenger = ScaffoldMessenger.of(ctx);

  messenger.hideCurrentSnackBar();
  messenger.showSnackBar(SnackBar(content: Text(message)));
}
