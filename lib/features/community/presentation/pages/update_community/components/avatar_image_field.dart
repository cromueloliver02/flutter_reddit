import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';

import '../../../cubits/cubits.dart';

class AvatarImageField extends StatelessWidget {
  final String avatar;

  const AvatarImageField({
    super.key,
    required this.avatar,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: context.read<EditCommunityFormCubit>().pickAvatarImage,
      child:
          BlocSelector<EditCommunityFormCubit, EditCommunityFormState, XFile?>(
        selector: (state) => state.avatarImageFile,
        builder: (ctx, avatarImageFile) {
          if (avatarImageFile == null) {
            return CircleAvatar(
              backgroundImage: NetworkImage(avatar),
              radius: 32,
            );
          }

          return CircleAvatar(
            backgroundImage: FileImage(File(avatarImageFile.path)),
            radius: 32,
          );
        },
      ),
    );
  }
}
