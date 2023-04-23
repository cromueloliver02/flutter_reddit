import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../../core/widgets/widgets.dart';
import '../../../cubits/cubits.dart';

class ImageFields extends StatelessWidget {
  final String currentAvatarImageUrl;
  final String currentBannerImageUrl;

  const ImageFields({
    super.key,
    required this.currentAvatarImageUrl,
    required this.currentBannerImageUrl,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        BlocBuilder<UpdateCommunityFormCubit, UpdateCommunityFormState>(
          buildWhen: (prev, curr) =>
              prev.bannerImageFile != curr.bannerImageFile,
          builder: (ctx, formState) => RDTBannerImageField(
            bannerImageUrl: currentBannerImageUrl,
            bannerImageFile: formState.bannerImageFile,
            onPickImage: ctx.read<UpdateCommunityFormCubit>().pickBannerImage,
          ),
        ),
        Positioned(
          left: 20,
          bottom: 0,
          child:
              BlocBuilder<UpdateCommunityFormCubit, UpdateCommunityFormState>(
            buildWhen: (prev, curr) =>
                prev.avatarImageFile != curr.avatarImageFile,
            builder: (ctx, formState) => RDTAvatarImageField(
              avatarImageUrl: currentAvatarImageUrl,
              avatarImageFile: formState.avatarImageFile,
              onPickImage: ctx.read<UpdateCommunityFormCubit>().pickAvatarImage,
            ),
          ),
        ),
      ],
    );
  }
}
