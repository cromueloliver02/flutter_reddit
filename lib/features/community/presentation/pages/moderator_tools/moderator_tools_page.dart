import 'package:flutter/material.dart';

import 'components/moderator_tools_view.dart';

class ModeratorToolsPage extends StatelessWidget {
  static const String name = 'moderator-tools';
  static const String path = name;

  const ModeratorToolsPage({super.key});

  @override
  Widget build(BuildContext context) => const ModeratorToolsView();
}
