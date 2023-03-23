import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../blocs/blocs.dart';

class AddModeratorAppBar extends StatelessWidget {
  const AddModeratorAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: const Text('Add Moderator'),
      actions: [
        BlocBuilder<CommunityMembersBloc, CommunityMembersState>(
          buildWhen: (prev, curr) => prev.status != curr.status,
          builder: (ctx, state) => IconButton(
            icon: const Icon(Icons.done),
            onPressed:
                state.status == CommunityMembersStatus.loading ? null : () {},
          ),
        ),
      ],
    );
  }
}
