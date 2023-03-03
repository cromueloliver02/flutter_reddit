import 'dart:async';

import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../features/auth/presentation/blocs/blocs.dart';
import '../../features/auth/presentation/cubits/cubits.dart';
import '../../features/auth/presentation/pages/pages.dart';
import '../../features/home/presentation/pages/pages.dart';
import '../blocs/blocs.dart';
import '../dependencies.dart';

class AppRouter {
  static final GoRouter router = GoRouter(
    initialLocation: LoginPage.path,
    redirect: _redirect,
    routes: <GoRoute>[
      GoRoute(
        path: HomePage.path,
        name: HomePage.name,
        builder: (ctx, state) => const HomePage(),
      ),
      GoRoute(
        path: LoginPage.path,
        name: LoginPage.name,
        builder: (ctx, state) => BlocProvider<SignInCubit>.value(
          value: sl<SignInCubit>(),
          child: const LoginPage(),
        ),
      ),
    ],
  );

  static FutureOr<String?> _redirect(BuildContext ctx, GoRouterState state) {
    final UserAuthStatus userAuthStatus =
        ctx.watch<AuthBlocImpl>().state.userAuthStatus;

    if (userAuthStatus == UserAuthStatus.authenticated) return '/';

    if (userAuthStatus == UserAuthStatus.unauthenticated) {
      return '/${LoginPage.name}';
    }

    return null;
  }
}
