import 'package:flutter/material.dart';

import 'edit_community_app_bar.dart';

class EditCommunityView extends StatelessWidget {
  const EditCommunityView({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(kToolbarHeight),
        child: EditCommunityAppBar(),
      ),
      body: Center(
        child: Text('EDIT COMMUNITY PAGE'),
      ),
    );
  }
}
