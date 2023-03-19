import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../pages.dart';

class ModeratorToolsView extends StatelessWidget {
  final String communityId;

  const ModeratorToolsView({
    super.key,
    required this.communityId,
  });

  void _goToEditCommunityPage(BuildContext ctx) {
    ctx.goNamed(
      EditCommunityPage.name,
      params: {'communityId': communityId},
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Mod tools')),
      body: Column(
        children: [
          ListTile(
            leading: const Icon(Icons.add_moderator),
            title: const Text('Add Moderator'),
            onTap: () {},
          ),
          ListTile(
            leading: const Icon(Icons.edit),
            title: const Text('Edit Community'),
            onTap: () => _goToEditCommunityPage(context),
          ),
        ],
      ),
    );
  }
}
