import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import 'components/login_view.dart';

class LoginPage extends StatelessWidget {
  static const String name = 'login';

  static final GoRoute route = GoRoute(
    path: '/$name',
    name: name,
    builder: (BuildContext ctx, GoRouterState state) => const LoginPage(),
  );

  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) => const LoginView();
}
