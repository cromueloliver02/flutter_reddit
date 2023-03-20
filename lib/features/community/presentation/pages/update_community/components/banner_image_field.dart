import 'dart:io';

import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';

import '../../../../../../core/constants/constants.dart';
import '../../../cubits/cubits.dart';

class BannerImageField extends StatelessWidget {
  final String banner;

  const BannerImageField({
    super.key,
    required this.banner,
  });

  @override
  Widget build(BuildContext context) {
    final TextTheme textTheme = Theme.of(context).textTheme;

    return BlocSelector<UpdateCommunityFormCubit, UpdateCommunityFormState,
        XFile?>(
      selector: (state) => state.bannerImageFile,
      builder: (ctx, bannerImageFile) => GestureDetector(
        onTap: ctx.read<UpdateCommunityFormCubit>().pickBannerImage,
        child: DottedBorder(
          radius: const Radius.circular(10),
          dashPattern: const [10, 4],
          strokeCap: StrokeCap.round,
          borderType: BorderType.RRect,
          color: bannerImageFile == null
              ? textTheme.bodyLarge!.color!
              : Colors.transparent,
          child: ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: SizedBox(
              width: double.infinity,
              height: 150,
              child: bannerImageFile != null
                  ? Image.file(
                      File(bannerImageFile.path),
                      fit: BoxFit.cover,
                    )
                  : banner.isEmpty || banner == kBannerDefault
                      ? const Center(
                          child: Icon(
                            Icons.camera_alt_outlined,
                            size: 40,
                          ),
                        )
                      : Image.network(
                          banner,
                          fit: BoxFit.cover,
                        ),
            ),
          ),
        ),
      ),
    );
  }
}
