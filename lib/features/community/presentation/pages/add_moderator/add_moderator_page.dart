import 'package:flutter/material.dart';

import 'components/add_moderator_view.dart';

class AddModeratorPage extends StatelessWidget {
  final String communityId;

  const AddModeratorPage({
    super.key,
    required this.communityId,
  });

  static const String name = 'add-moderator';
  static const String path = name;

  @override
  Widget build(BuildContext context) => const AddModeratorView();
}
