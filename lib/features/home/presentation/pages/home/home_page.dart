import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import 'components/home_view.dart';

class HomePage extends StatelessWidget {
  static const String name = 'home';

  static final GoRoute route = GoRoute(
    path: '/',
    name: name,
    builder: (BuildContext context, GoRouterState state) => const HomePage(),
  );

  const HomePage({super.key});

  @override
  Widget build(BuildContext context) => const HomeView();
}
