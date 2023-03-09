import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'core/blocs/blocs.dart';
import 'core/dependencies.dart';
import 'core/utils/utils.dart';
import 'features/auth/presentation/blocs/blocs.dart';
import 'features/auth/presentation/pages/pages.dart';
import 'features/home/presentation/pages/pages.dart';

class RedditApp extends StatelessWidget {
  const RedditApp({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<AuthBlocImpl>.value(
      value: sl<AuthBlocImpl>(),
      child: BlocListener<AuthBlocImpl, AuthState>(
        listenWhen: (prev, curr) => prev.userAuthStatus != curr.userAuthStatus,
        listener: (ctx, state) {
          if (state.userAuthStatus == UserAuthStatus.authenticated) {
            AppRouter.router.goNamed(HomePage.name);
          }

          if (state.userAuthStatus == UserAuthStatus.unauthenticated) {
            AppRouter.router.goNamed(LoginPage.name);
          }

          if (state.userAuthStatus == UserAuthStatus.unknown) {
            AppRouter.router.goNamed(SplashPage.name);
          }
        },
        child: MaterialApp.router(
          title: 'Reddit',
          debugShowCheckedModeBanner: false,
          themeMode: ThemeMode.dark,
          theme: AppTheme.lightModeAppTheme,
          darkTheme: AppTheme.darkModeAppTheme,
          routerConfig: AppRouter.router,
        ),
      ),
    );
  }
}
