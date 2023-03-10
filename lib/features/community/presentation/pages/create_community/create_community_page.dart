import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../../../../core/blocs/blocs.dart';
import '../../../../../core/utils/utils.dart';
import '../../blocs/blocs.dart';
import 'components/create_community_view.dart';

class CreateCommunityPage extends StatelessWidget {
  static const String name = 'create-community';
  static const String path = name;

  const CreateCommunityPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocListener<CommunityBlocImpl, CommunityState>(
      listenWhen: (prev, curr) => prev.formStatus != curr.formStatus,
      listener: (ctx, state) {
        if (state.formStatus == CommunityFormStatus.success) {
          showSnackBar(ctx, message: 'Community successfully created.');
          ctx.pop();
        }

        if (state.formStatus == CommunityFormStatus.failure) {
          showSnackBar(ctx, message: state.error.message);
        }
      },
      child: const CreateCommunityView(),
    );
  }
}
