import 'package:flutter/material.dart';

import 'components/moderator_tools_view.dart';

class ModeratorToolsPage extends StatelessWidget {
  final String communityId;

  const ModeratorToolsPage({
    super.key,
    required this.communityId,
  });

  static const String name = 'moderator-tools';
  static const String path = name;

  @override
  Widget build(BuildContext context) {
    return ModeratorToolsView(communityId: communityId);
  }
}
