import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../cubits/cubits.dart';

class AddModeratorAppBar extends StatelessWidget {
  final String communityId;

  const AddModeratorAppBar({
    super.key,
    required this.communityId,
  });

  void _saveModerators(BuildContext ctx) {
    ctx.read<AddModeratorCubit>().saveModerators(communityId);
  }

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: const Text('Add Moderator'),
      actions: [
        BlocBuilder<AddModeratorCubit, AddModeratorState>(
          buildWhen: (prev, curr) => prev.status != curr.status,
          builder: (ctx, state) => IconButton(
            icon: const Icon(Icons.done),
            onPressed: state.status == AddModeratorStatus.loading
                ? null
                : () => _saveModerators(context),
          ),
        ),
      ],
    );
  }
}
