import 'package:flutter/material.dart';

import 'components/home_view.dart';

class HomePage extends StatelessWidget {
  static const String name = 'home';
  static const String path = '/';

  const HomePage({super.key});

  @override
  Widget build(BuildContext context) => const HomeView();
}
