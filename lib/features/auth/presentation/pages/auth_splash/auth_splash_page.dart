import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../core/blocs/blocs.dart';
import '../../../../../core/utils/utils.dart';
import 'components/auth_splash_view.dart';

class AuthSplashPage extends StatefulWidget {
  static const String name = 'auth-splash';
  static const String path = '/$name';

  const AuthSplashPage({super.key});

  @override
  State<AuthSplashPage> createState() => _AuthSplashPageState();
}

class _AuthSplashPageState extends State<AuthSplashPage> {
  void _authListener(BuildContext ctx, AuthState state) {
    if (state.status == AuthStatus.failure) {
      showErrorDialog(ctx, message: state.error.message);
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthBloc, AuthState>(
      listenWhen: (prev, curr) => prev.status != curr.status,
      listener: _authListener,
      child: const AuthSplashView(),
    );
  }

  // start authentication
  @override
  void initState() {
    super.initState();

    context.read<AuthBloc>().add(AuthStarted());
  }
}
