import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../../../../../core/blocs/blocs.dart';
import '../../../../../../core/widgets/widgets.dart';
import '../../../../domain/entities/entities.dart';
import '../../../blocs/blocs.dart';
import '../../../cubits/cubits.dart';
import '../../pages.dart';

class CommunityDetailsSliverHeader extends StatelessWidget {
  final CommunityDetailsState state;

  const CommunityDetailsSliverHeader({
    super.key,
    required this.state,
  });

  void _goToModToolsPage(BuildContext ctx) {
    ctx.goNamed(
      ModeratorToolsPage.name,
      params: {'communityId': state.community!.id},
    );
  }

  void _joinOrLeaveCommunity(BuildContext ctx) {
    final String userId = ctx.read<AuthBloc>().state.user!.id;
    final Community community =
        ctx.read<CommunityDetailsBloc>().state.community!;

    ctx
        .read<JoinOrLeaveCommunityCubit>()
        .joinOrLeaveCommunity(community: community, userId: userId);
  }

  @override
  Widget build(BuildContext context) {
    final TextTheme textTheme = Theme.of(context).textTheme;
    // TODO: refactor this code, this is a bad practice
    final String userId = context.read<AuthBloc>().state.user!.id;

    return SliverPadding(
      padding: const EdgeInsets.all(16),
      sliver: SliverList(
        delegate: SliverChildListDelegate([
          Align(
            alignment: Alignment.topLeft,
            child: CircleAvatar(
              backgroundImage: NetworkImage(state.community!.avatar),
              radius: 35,
            ),
          ),
          const SizedBox(height: 10),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'r/${state.community!.name}',
                style: textTheme.bodyLarge!.copyWith(
                  fontWeight: FontWeight.bold,
                ),
              ),
              if (state.community!.mods.contains(userId))
                RDTOutlinedButton(
                  title: 'Mod Tools',
                  onPressed: () => _goToModToolsPage(context),
                ),
              if (!state.community!.mods.contains(userId))
                RDTOutlinedButton(
                  title: state.community!.members.contains(userId)
                      ? 'Joined'
                      : 'Join',
                  onPressed: () => _joinOrLeaveCommunity(context),
                ),
            ],
          ),
          const SizedBox(height: 10),
          Text('${state.community!.members.length} members'),
        ]),
      ),
    );
  }
}
