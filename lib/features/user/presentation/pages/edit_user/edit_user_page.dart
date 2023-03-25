import 'package:flutter/material.dart';

import 'components/edit_user_view.dart';

class EditUserPage extends StatelessWidget {
  final String userId;

  const EditUserPage({
    super.key,
    required this.userId,
  });

  static const String name = 'edit-user';
  static const String path = name;

  @override
  Widget build(BuildContext context) {
    return const EditUserView();
  }
}
