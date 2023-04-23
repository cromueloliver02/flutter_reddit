import 'dart:io';

import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

import '../../../../../../core/constants/constants.dart';

class RDTBannerImageField extends StatelessWidget {
  final String banner;
  final XFile? bannerImageFile;
  final VoidCallback onPickBannerImage;

  const RDTBannerImageField({
    super.key,
    required this.banner,
    required this.bannerImageFile,
    required this.onPickBannerImage,
  });

  @override
  Widget build(BuildContext context) {
    final TextTheme textTheme = Theme.of(context).textTheme;

    return GestureDetector(
      onTap: onPickBannerImage,
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
                    File(bannerImageFile!.path),
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
    );
  }
}
