import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../../core/widgets/widgets.dart';
import '../../../blocs/blocs.dart';
import 'add_moderator_app_bar.dart';
import 'community_member_list.dart';

class AddModeratorView extends StatelessWidget {
  const AddModeratorView({super.key});

  Widget _communityMembersBuilder(
    BuildContext ctx,
    CommunityMembersState state,
  ) {
    if (state.status == CommunityMembersStatus.initial) {
      return const SizedBox.shrink();
    }

    if (state.status == CommunityMembersStatus.loading) {
      return const RDTLoaderCard();
    }

    if (state.status == CommunityMembersStatus.failure) {
      return const RDTErrorCard();
    }

    if (state.communityMembers.isEmpty) {
      return const RDTEmptyMessageCard(
        message: 'No members for this community',
      );
    }

    return CommunityMemberList(communityMembers: state.communityMembers);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const PreferredSize(
        preferredSize: Size.fromHeight(kToolbarHeight),
        child: AddModeratorAppBar(),
      ),
      body: BlocBuilder<CommunityMembersBloc, CommunityMembersState>(
        buildWhen: (prev, curr) => prev.status != curr.status,
        builder: _communityMembersBuilder,
      ),
    );
  }
}
