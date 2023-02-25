import 'package:flutter/material.dart';

import 'core/utils/utils.dart';

class RedditApp extends StatelessWidget {
  const RedditApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'Reddit',
      debugShowCheckedModeBanner: false,
      themeMode: ThemeMode.dark,
      theme: AppTheme.lightModeAppTheme,
      darkTheme: AppTheme.darkModeAppTheme,
      routerConfig: AppRouter.router,
    );
  }
}
