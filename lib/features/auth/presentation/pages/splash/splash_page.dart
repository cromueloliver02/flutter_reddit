import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../core/blocs/blocs.dart';
import '../../blocs/blocs.dart';
import 'components/splash_view.dart';

class SplashPage extends StatefulWidget {
  static const String name = 'splash';
  static const String path = '/$name';

  const SplashPage({super.key});

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  @override
  Widget build(BuildContext context) => const SplashView();

  @override
  void initState() {
    super.initState();

    context.read<AuthBlocImpl>().add(AuthStarted());
  }
}
