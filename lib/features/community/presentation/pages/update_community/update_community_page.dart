import 'package:flutter/material.dart';

import 'components/update_community_view.dart';

class UpdateCommunityPage extends StatelessWidget {
  final String communityId;

  const UpdateCommunityPage({
    super.key,
    required this.communityId,
  });

  static const String name = 'update-community';
  static const String path = name;

  @override
  Widget build(BuildContext context) => const UpdateCommunityView();
}
