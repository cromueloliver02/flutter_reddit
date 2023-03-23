import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../blocs/blocs.dart';
import '../../cubits/cubits.dart';
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
  @override
  Widget build(BuildContext context) => const AddModeratorView();

  @override
  void initState() {
    context
        .read<CommunityMembersBloc>()
        .add(CommunityMembersFetched(communityId: widget.communityId));

    final List<String> moderatorIds =
        context.read<CommunityDetailsBloc>().state.community!.mods;
    context.read<AddModeratorFormCubit>().setSelectedModerators(moderatorIds);

    super.initState();
  }
}
