import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../blocs/blocs.dart';
import 'edit_user_app_bar.dart';
import 'image_fields.dart';

class EditUserView extends StatelessWidget {
  const EditUserView({super.key});

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);

    return Scaffold(
      backgroundColor: theme.scaffoldBackgroundColor,
      appBar: const PreferredSize(
        preferredSize: Size.fromHeight(kToolbarHeight),
        child: EditUserAppBar(),
      ),
      body: Padding(
        padding: const EdgeInsets.all(10),
        child: BlocBuilder<UserDetailsBloc, UserDetailsState>(
          builder: (ctx, state) => SizedBox(
            height: 180,
            child: ImageFields(
              currentAvatarImageUrl: state.user!.profilePic,
              currentBannerImageUrl: state.user!.banner,
              onPickAvatarImage: () {},
              onPickBannerImage: () {},
            ),
          ),
        ),
      ),
    );
  }
}
