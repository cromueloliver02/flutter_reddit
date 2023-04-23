import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../../core/widgets/widgets.dart';
import '../../../cubits/cubits.dart';

class ImageFields extends StatelessWidget {
  final String currentAvatarImageUrl;
  final String currentBannerImageUrl;
  final VoidCallback onPickBannerImage;
  final VoidCallback onPickAvatarImage;

  const ImageFields({
    super.key,
    required this.currentAvatarImageUrl,
    required this.currentBannerImageUrl,
    required this.onPickBannerImage,
    required this.onPickAvatarImage,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<EditUserFormCubit, EditUserFormState>(
      builder: (ctx, state) => Stack(
        children: [
          RDTBannerImageField(
            bannerImageUrl: currentBannerImageUrl,
            bannerImageFile: state.bannerImageFile,
            onPickImage: onPickBannerImage,
          ),
          Positioned(
            left: 20,
            bottom: 0,
            child: RDTAvatarImageField(
              avatarImageUrl: currentAvatarImageUrl,
              avatarImageFile: state.avatarImageFile,
              onPickImage: onPickAvatarImage,
            ),
          ),
        ],
      ),
    );
  }
}
