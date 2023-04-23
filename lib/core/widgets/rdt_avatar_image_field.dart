import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class RDTAvatarImageField extends StatelessWidget {
  final String avatarImageUrl;
  final XFile? avatarImageFile;
  final VoidCallback onPickImage;

  const RDTAvatarImageField({
    super.key,
    required this.avatarImageUrl,
    required this.avatarImageFile,
    required this.onPickImage,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPickImage,
      child: Builder(
        builder: (ctx) {
          if (avatarImageFile == null) {
            return CircleAvatar(
              backgroundImage: NetworkImage(avatarImageUrl),
              radius: 32,
            );
          }

          return CircleAvatar(
            backgroundImage: FileImage(File(avatarImageFile!.path)),
            radius: 32,
          );
        },
      ),
    );
  }
}
