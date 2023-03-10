import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../../../community/presentation/pages/pages.dart';

class CommunityListDrawer extends StatelessWidget {
  const CommunityListDrawer({super.key});

  void _goToCreateCommunityPage(BuildContext ctx) {
    Navigator.pop(ctx);
    ctx.pushNamed(CreateCommunityPage.name);
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: SafeArea(
        child: Column(
          children: [
            ListTile(
              title: const Text('Create a community'),
              leading: const Icon(Icons.add),
              onTap: () => _goToCreateCommunityPage(context),
            ),
          ],
        ),
      ),
    );
  }
}
