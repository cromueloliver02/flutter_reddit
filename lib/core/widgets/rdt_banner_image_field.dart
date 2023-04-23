import 'dart:io';

import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

import '../../../../../../core/constants/constants.dart';

class RDTBannerImageField extends StatelessWidget {
  final String bannerImageUrl;
  final XFile? bannerImageFile;
  final VoidCallback onPickImage;

  const RDTBannerImageField({
    super.key,
    required this.bannerImageUrl,
    required this.bannerImageFile,
    required this.onPickImage,
  });

  @override
  Widget build(BuildContext context) {
    final TextTheme textTheme = Theme.of(context).textTheme;

    return GestureDetector(
      onTap: onPickImage,
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
                : bannerImageUrl.isEmpty || bannerImageUrl == kBannerDefault
                    ? const Center(
                        child: Icon(
                          Icons.camera_alt_outlined,
                          size: 40,
                        ),
                      )
                    : Image.network(
                        bannerImageUrl,
                        fit: BoxFit.cover,
                      ),
          ),
        ),
      ),
    );
  }
}
