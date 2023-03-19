import 'package:flutter/material.dart';

import 'edit_community_app_bar.dart';
import 'image_field.dart';

class EditCommunityView extends StatelessWidget {
  const EditCommunityView({super.key});

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);

    return Scaffold(
      backgroundColor: theme.scaffoldBackgroundColor,
      appBar: const PreferredSize(
        preferredSize: Size.fromHeight(kToolbarHeight),
        child: EditCommunityAppBar(),
      ),
      body: Padding(
        padding: const EdgeInsets.all(10),
        child: Column(
          children: const [
            ImageField(),
          ],
        ),
      ),
    );
  }
}
