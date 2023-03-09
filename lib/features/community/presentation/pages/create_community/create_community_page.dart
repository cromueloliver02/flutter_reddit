import 'package:flutter/material.dart';

import 'components/create_community_view.dart';

class CreateCommunityPage extends StatelessWidget {
  static const String name = 'create-community';
  static const String path = name;

  const CreateCommunityPage({super.key});

  @override
  Widget build(BuildContext context) => const CreateCommunityView();
}
