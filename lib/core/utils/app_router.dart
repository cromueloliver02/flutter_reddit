import 'dart:async';

import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../features/auth/presentation/pages/pages.dart';
import '../../features/auth/presentation/blocs/blocs.dart';
import '../../features/home/presentation/pages/pages.dart';
import '../blocs/blocs.dart';

class AppRouter {
  static final GoRouter router = GoRouter(
    initialLocation: '/login',
    redirect: _redirect,
    routes: <GoRoute>[
      HomePage.route,
      LoginPage.route,
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
