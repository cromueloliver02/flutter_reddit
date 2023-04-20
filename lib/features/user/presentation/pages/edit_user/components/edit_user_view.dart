import 'package:flutter/material.dart';

import 'edit_user_app_bar.dart';

class EditUserView extends StatelessWidget {
  const EditUserView({super.key});

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);

    return Scaffold(
      backgroundColor: theme.scaffoldBackgroundColor,
      appBar: const PreferredSize(
        preferredSize: Size.fromHeight(kToolbarHeight),
        child: EditUserAppBar(),
      ),
      body: const Center(
        child: Text('EDIT PROFILE PAGE'),
      ),
    );
  }
}
