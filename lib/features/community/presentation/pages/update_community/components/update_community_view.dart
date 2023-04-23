import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../../core/widgets/widgets.dart';
import '../../../blocs/blocs.dart';
import '../../../cubits/cubits.dart';
import 'image_fields.dart';
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
      body: BlocBuilder<UpdateCommunityCubit, UpdateCommunityState>(
        buildWhen: (prev, curr) => prev.status != curr.status,
        builder: (ctx, state) {
          if (state.status == UpdateCommunityStatus.loading) {
            return const RDTLoaderCard();
          }

          return Padding(
            padding: const EdgeInsets.all(10),
            child: BlocBuilder<CommunityDetailsBloc, CommunityDetailsState>(
              builder: (ctx, state) => SizedBox(
                height: 180,
                child: ImageFields(
                  currentAvatarImageUrl: state.community!.avatar,
                  currentBannerImageUrl: state.community!.banner,
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
