import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../../core/constants/constants.dart';
import '../../../cubits/cubits.dart';

class ImageField extends StatelessWidget {
  const ImageField({super.key});

  @override
  Widget build(BuildContext context) {
    final TextTheme textTheme = Theme.of(context).textTheme;

    return BlocBuilder<CommunityDetailsCubit, CommunityDetailsState>(
      builder: (ctx, state) {
        final String banner = state.community!.banner;
        final String avatar = state.community!.avatar;

        return SizedBox(
          height: 180,
          child: Stack(
            children: [
              DottedBorder(
                color: textTheme.bodyLarge!.color!,
                radius: const Radius.circular(10),
                dashPattern: const [10, 4],
                strokeCap: StrokeCap.round,
                borderType: BorderType.RRect,
                child: Container(
                  width: double.infinity,
                  height: 150,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: banner.isEmpty || banner == kBannerDefault
                      ? const Center(
                          child: Icon(
                            Icons.camera_alt_outlined,
                            size: 40,
                          ),
                        )
                      : Image.network(banner, fit: BoxFit.cover),
                ),
              ),
              Positioned(
                left: 20,
                bottom: 0,
                child: CircleAvatar(
                  backgroundImage: NetworkImage(avatar),
                  radius: 32,
                ),
              )
            ],
          ),
        );
      },
    );
  }
}
