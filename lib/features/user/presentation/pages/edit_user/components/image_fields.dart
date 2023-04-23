import 'package:flutter/material.dart';

import '../../../../../../core/widgets/widgets.dart';

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
    return Stack(
      children: [
        RDTBannerImageField(
          bannerImageUrl: currentBannerImageUrl,
          bannerImageFile: null,
          onPickImage: onPickBannerImage,
        ),
        Positioned(
          left: 20,
          bottom: 0,
          child: RDTAvatarImageField(
            avatarImageUrl: currentAvatarImageUrl,
            avatarImageFile: null,
            onPickImage: onPickAvatarImage,
          ),
        ),
      ],
    );
  }
}
