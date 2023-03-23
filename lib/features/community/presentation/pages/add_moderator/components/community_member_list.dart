import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../auth/domain/entities/entities.dart';
import '../../../cubits/cubits.dart';

class CommunityMemberList extends StatelessWidget {
  final List<User> communityMembers;

  const CommunityMemberList({
    super.key,
    required this.communityMembers,
  });

  void _toggleModerator(BuildContext ctx, {required String memberId}) {
    ctx.read<AddModeratorFormCubit>().toggleModerator(memberId);
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AddModeratorFormCubit, AddModeratorFormState>(
      builder: (ctx, state) => ListView.builder(
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
      ),
    );
  }
}
