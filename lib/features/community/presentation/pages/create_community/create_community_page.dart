import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../../../../core/utils/utils.dart';
import '../../cubits/cubits.dart';
import 'components/create_community_view.dart';

class CreateCommunityPage extends StatelessWidget {
  const CreateCommunityPage({super.key});

  static const String name = 'create-community';
  static const String path = name;

  @override
  Widget build(BuildContext context) {
    return BlocListener<CreateCommunityCubit, CreateCommunityState>(
      listenWhen: (prev, curr) => prev.status != curr.status,
      listener: (ctx, state) {
        if (state.status == CreateCommunityStatus.success) {
          showSnackBar(ctx, message: 'Community successfully created.');
          ctx.pop();
        }

        if (state.status == CreateCommunityStatus.failure) {
          showSnackBar(ctx, message: state.error.message);
        }
      },
      child: const CreateCommunityView(),
    );
  }
}
