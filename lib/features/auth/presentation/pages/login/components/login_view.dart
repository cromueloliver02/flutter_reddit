import 'package:flutter/material.dart';

import 'login_app_bar.dart';

class LoginView extends StatelessWidget {
  const LoginView({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(kToolbarHeight),
        child: LoginAppBar(),
      ),
      body: Center(
        child: Text('LOGIN PAGE'),
      ),
    );
  }
}
