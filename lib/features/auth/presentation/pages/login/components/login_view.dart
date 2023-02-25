import 'package:flutter/material.dart';

import '../../../../../../core/constants/constants.dart';
import '../../../../../../core/widgets/widgets.dart';
import 'login_app_bar.dart';

class LoginView extends StatelessWidget {
  const LoginView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const PreferredSize(
        preferredSize: Size.fromHeight(kToolbarHeight),
        child: LoginAppBar(),
      ),
      body: Column(
        children: [
          const SizedBox(height: 30),
          const Text(
            'Dive into anything',
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              letterSpacing: 0.5,
            ),
          ),
          const SizedBox(height: 30),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: Image.asset(
              kLoginEmotePath,
              height: 400,
            ),
          ),
          const SizedBox(height: 20),
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 10),
            child: RDTGoogleSignInButton(),
          ),
        ],
      ),
    );
  }
}
