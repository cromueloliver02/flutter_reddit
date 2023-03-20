import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../pages.dart';
import 'moderator_tools_app_bar.dart';

class ModeratorToolsView extends StatelessWidget {
  final String communityId;

  const ModeratorToolsView({
    super.key,
    required this.communityId,
  });

  void _goToUpdateCommunityPage(BuildContext ctx) {
    ctx.goNamed(
      UpdateCommunityPage.name,
      params: {'communityId': communityId},
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const PreferredSize(
        preferredSize: Size.fromHeight(kToolbarHeight),
        child: ModeratorToolsAppBar(),
      ),
      body: Column(
        children: [
          ListTile(
            leading: const Icon(Icons.add_moderator),
            title: const Text('Add Moderator'),
            onTap: () {},
          ),
          ListTile(
            leading: const Icon(Icons.edit),
            title: const Text('Update Community'),
            onTap: () => _goToUpdateCommunityPage(context),
          ),
        ],
      ),
    );
  }
}
