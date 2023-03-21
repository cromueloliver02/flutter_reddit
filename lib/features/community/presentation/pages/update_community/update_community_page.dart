import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../../../../core/utils/utils.dart';
import '../../../../home/presentation/pages/pages.dart';
import '../../cubits/cubits.dart';
import 'components/update_community_view.dart';

class UpdateCommunityPage extends StatelessWidget {
  final String communityId;

  const UpdateCommunityPage({
    super.key,
    required this.communityId,
  });

  static const String name = 'update-community';
  static const String path = name;

  void _updateCommunityListener(BuildContext ctx, UpdateCommunityState state) {
    if (state.status == UpdateCommunityStatus.success) {
      ctx.goNamed(HomePage.name);
      showSnackBar(ctx, message: 'Community successfully updated');
    }

    if (state.status == UpdateCommunityStatus.failure) {
      showErrorDialog(ctx, message: state.error.message);
    }
  }

  void _updateCommunityFormListener(
    BuildContext ctx,
    UpdateCommunityFormState state,
  ) {
    if (state.pickImageStatus == PickImageStatus.failure) {
      showErrorDialog(ctx, message: state.error.message);
    }
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocListener(
      listeners: [
        BlocListener<UpdateCommunityCubit, UpdateCommunityState>(
          listenWhen: (prev, curr) => prev.status != curr.status,
          listener: _updateCommunityListener,
        ),
        BlocListener<UpdateCommunityFormCubit, UpdateCommunityFormState>(
          listenWhen: (prev, curr) =>
              prev.pickImageStatus != curr.pickImageStatus,
          listener: _updateCommunityFormListener,
        ),
      ],
      child: const UpdateCommunityView(),
    );
  }
}
