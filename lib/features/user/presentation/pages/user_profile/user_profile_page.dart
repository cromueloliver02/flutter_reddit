import 'package:flutter/material.dart';

import 'components/user_profile_view.dart';

class UserProfilePage extends StatelessWidget {
  const UserProfilePage({super.key});

  static const String name = 'user-profile';
  static const String path = name;

  @override
  Widget build(BuildContext context) => const UserProfileView();
}
