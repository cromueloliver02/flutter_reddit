import 'package:flutter/material.dart';

import 'components/edit_community_view.dart';

class EditCommunityPage extends StatelessWidget {
  final String communityId;

  static const String name = 'edit-community';
  static const String path = name;

  const EditCommunityPage({
    super.key,
    required this.communityId,
  });

  @override
  Widget build(BuildContext context) => const EditCommunityView();
}
