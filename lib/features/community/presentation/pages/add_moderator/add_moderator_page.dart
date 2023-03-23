import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../blocs/blocs.dart';
import '../../cubits/cubits.dart';
import '../pages.dart';
import 'components/add_moderator_view.dart';

class AddModeratorPage extends StatefulWidget {
  final String communityId;

  const AddModeratorPage({
    super.key,
    required this.communityId,
  });

  static const String name = 'add-moderator';
  static const String path = name;

  @override
  State<AddModeratorPage> createState() => _AddModeratorPageState();
}

class _AddModeratorPageState extends State<AddModeratorPage> {
  void _addModeratorListener(BuildContext ctx, AddModeratorState state) {
    if (state.status == AddModeratorStatus.success) {
      ctx.goNamed(
        ModeratorToolsPage.name,
        params: {'communityId': widget.communityId},
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<AddModeratorCubit, AddModeratorState>(
      listenWhen: (prev, curr) => prev.status != curr.status,
      listener: _addModeratorListener,
      child: AddModeratorView(communityId: widget.communityId),
    );
  }

  @override
  void initState() {
    context
        .read<CommunityMembersBloc>()
        .add(CommunityMembersFetched(communityId: widget.communityId));

    final List<String> moderatorIds =
        context.read<CommunityDetailsBloc>().state.community!.mods;
    context.read<AddModeratorCubit>().setSelectedModerators(moderatorIds);

    super.initState();
  }
}
