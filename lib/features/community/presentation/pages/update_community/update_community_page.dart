import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_reddit/core/utils/utils.dart';
import 'package:go_router/go_router.dart';

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
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<UpdateCommunityCubit, UpdateCommunityState>(
      listenWhen: (prev, curr) => prev.status != curr.status,
      listener: _updateCommunityListener,
      child: const UpdateCommunityView(),
    );
  }
}
