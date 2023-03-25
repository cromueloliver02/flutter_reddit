import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../../core/entities/entities.dart';
import '../../../../../../core/widgets/widgets.dart';
import '../../../cubits/cubits.dart';

class CommunityMemberList extends StatelessWidget {
  final List<User> communityMembers;

  const CommunityMemberList({
    super.key,
    required this.communityMembers,
  });

  void _toggleModerator(BuildContext ctx, {required String memberId}) {
    ctx.read<AddModeratorCubit>().toggleModerator(memberId);
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AddModeratorCubit, AddModeratorState>(
      builder: (ctx, state) {
        if (state.status == AddModeratorStatus.loading) {
          return const RDTLoaderCard();
        }

        if (state.status == AddModeratorStatus.failure) {
          return const RDTErrorCard();
        }

        if (state.status == AddModeratorStatus.success) {
          return const SizedBox.shrink();
        }

        return ListView.builder(
          itemCount: communityMembers.length,
          itemBuilder: (ctx, idx) {
            final User member = communityMembers[idx];

            return CheckboxListTile(
              value: state.moderatorIds.contains(member.id),
              title: Text(member.name),
              onChanged: (isChecked) => _toggleModerator(
                context,
                memberId: member.id,
              ),
            );
          },
        );
      },
    );
  }
}
