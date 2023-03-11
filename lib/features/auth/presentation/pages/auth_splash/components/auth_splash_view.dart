import 'package:flutter/material.dart';

class AuthSplashView extends StatelessWidget {
  const AuthSplashView({super.key});

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);

    return Scaffold(
      body: Container(
        color: theme.scaffoldBackgroundColor,
        alignment: Alignment.center,
        child: SizedBox(
          width: 100,
          height: 100,
          child: Image.asset('assets/images/logo.png'),
        ),
      ),
    );
  }
}
