import 'package:flutter/material.dart';

import 'components/login_view.dart';

class LoginPage extends StatelessWidget {
  static const String name = 'login';
  static const String path = '/$name';

  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) => const LoginView();
}
