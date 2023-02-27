import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'core/dependencies.dart';
import 'core/utils/utils.dart';
import 'features/auth/presentation/blocs/blocs.dart';

class RedditApp extends StatelessWidget {
  const RedditApp({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<AuthBlocImpl>.value(
      value: sl<AuthBlocImpl>(),
      child: MaterialApp.router(
        title: 'Reddit',
        debugShowCheckedModeBanner: false,
        themeMode: ThemeMode.dark,
        theme: AppTheme.lightModeAppTheme,
        darkTheme: AppTheme.darkModeAppTheme,
        routerConfig: AppRouter.router,
      ),
    );
  }
}
