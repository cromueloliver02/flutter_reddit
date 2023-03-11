import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'core/blocs/blocs.dart';
import 'core/utils/utils.dart';
import 'features/auth/presentation/pages/pages.dart';

class RedditApp extends StatelessWidget {
  const RedditApp({super.key});

  void _authListener(BuildContext ctx, AuthState state) {
    if (state.userAuthStatus == UserAuthStatus.authenticated) {
      AppRouter.router.goNamed(InitSplashPage.name);
    }

    if (state.userAuthStatus == UserAuthStatus.unauthenticated) {
      AppRouter.router.goNamed(LoginPage.name);
    }

    if (state.userAuthStatus == UserAuthStatus.unknown) {
      AppRouter.router.goNamed(AuthSplashPage.name);
    }
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: GlobalBlocProviders.blocProviders,
      child: BlocListener<AuthBloc, AuthState>(
        listenWhen: (prev, curr) => prev.userAuthStatus != curr.userAuthStatus,
        listener: _authListener,
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
