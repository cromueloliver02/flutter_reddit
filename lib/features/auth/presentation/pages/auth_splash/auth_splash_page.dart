import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../core/blocs/blocs.dart';
import '../../blocs/blocs.dart';
import 'components/auth_splash_view.dart';

class AuthSplashPage extends StatefulWidget {
  static const String name = 'auth-splash';
  static const String path = '/$name';

  const AuthSplashPage({super.key});

  @override
  State<AuthSplashPage> createState() => _AuthSplashPageState();
}

class _AuthSplashPageState extends State<AuthSplashPage> {
  @override
  Widget build(BuildContext context) => const AuthSplashView();

  // start authentication
  @override
  void initState() {
    super.initState();

    context.read<AuthBlocImpl>().add(AuthStarted());
  }
}
