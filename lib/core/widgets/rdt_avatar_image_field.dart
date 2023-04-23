import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class RDTAvatarImageField extends StatelessWidget {
  final String avatar;
  final XFile? avatarImageFile;
  final VoidCallback onPickAvatarImage;

  const RDTAvatarImageField({
    super.key,
    required this.avatar,
    required this.avatarImageFile,
    required this.onPickAvatarImage,
  });

  @override
  Widget build(BuildContext context) {
    if (avatarImageFile == null) {
      return CircleAvatar(
        backgroundImage: NetworkImage(avatar),
        radius: 32,
      );
    }

    return GestureDetector(
      onTap: onPickAvatarImage,
      child: CircleAvatar(
        backgroundImage: FileImage(File(avatarImageFile!.path)),
        radius: 32,
      ),
    );
  }
}
