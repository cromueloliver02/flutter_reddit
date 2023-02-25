import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../../../../core/dependencies.dart';
import '../../cubits/cubits.dart';
import 'components/login_view.dart';

class LoginPage extends StatelessWidget {
  static const String name = 'login';

  static final GoRoute route = GoRoute(
    path: '/$name',
    name: name,
    builder: (BuildContext ctx, GoRouterState state) {
      return BlocProvider<SignInCubit>.value(
        value: sl<SignInCubit>(),
        child: const LoginPage(),
      );
    },
  );

  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) => const LoginView();
}
