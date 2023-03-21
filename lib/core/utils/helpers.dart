import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

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

// TODO: to be removed
Future<XFile?> pickImage() async {
  final ImagePicker picker = ImagePicker();
  final XFile? imageFile = await picker.pickImage(source: ImageSource.gallery);

  return imageFile;
}
