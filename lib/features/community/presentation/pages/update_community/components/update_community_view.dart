import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../cubits/cubits.dart';
import 'avatar_image_field.dart';
import 'banner_image_field.dart';
import 'update_community_app_bar.dart';

class UpdateCommunityView extends StatelessWidget {
  const UpdateCommunityView({super.key});

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);

    return Scaffold(
      backgroundColor: theme.scaffoldBackgroundColor,
      appBar: const PreferredSize(
        preferredSize: Size.fromHeight(kToolbarHeight),
        child: UpdateCommunityAppBar(),
      ),
      body: Padding(
        padding: const EdgeInsets.all(10),
        child: Column(
          children: [
            BlocBuilder<CommunityDetailsCubit, CommunityDetailsState>(
              builder: (ctx, state) => SizedBox(
                height: 180,
                child: Stack(
                  children: [
                    BannerImageField(banner: state.community!.banner),
                    Positioned(
                      left: 20,
                      bottom: 0,
                      child: AvatarImageField(avatar: state.community!.avatar),
                    )
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
