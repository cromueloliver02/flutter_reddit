import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';

import '../../../../domain/entities/entities.dart';
import '../../../blocs/blocs.dart';
import '../../../cubits/cubits.dart';

class UpdateCommunityAppBar extends StatelessWidget {
  const UpdateCommunityAppBar({super.key});

  void _save(BuildContext ctx) {
    final CommunityDetailsBloc communityDetailsCubit =
        ctx.read<CommunityDetailsBloc>();
    final UpdateCommunityFormCubit updateCommunityFormCubit =
        ctx.read<UpdateCommunityFormCubit>();

    final Community community = communityDetailsCubit.state.community!;
    final XFile? avatarImage = updateCommunityFormCubit.state.avatarImageFile;
    final XFile? bannerImage = updateCommunityFormCubit.state.bannerImageFile;

    ctx.read<UpdateCommunityCubit>().updateCommunity(
          community: community,
          avatarImageFile: avatarImage != null ? File(avatarImage.path) : null,
          bannerImageFile: bannerImage != null ? File(bannerImage.path) : null,
        );
  }

  @override
  Widget build(BuildContext context) {
    return AppBar(
      centerTitle: false,
      title: const Text('Update Community'),
      actions: [
        BlocBuilder<UpdateCommunityCubit, UpdateCommunityState>(
          builder: (ctx, state) => TextButton(
            onPressed: state.status == UpdateCommunityStatus.loading
                ? null
                : () => _save(context),
            child: const Text('Save'),
          ),
        ),
      ],
    );
  }
}
