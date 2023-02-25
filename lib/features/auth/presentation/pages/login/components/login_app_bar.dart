import 'package:flutter/material.dart';

import '../../../../../../core/constants/constants.dart';

class LoginAppBar extends StatelessWidget {
  const LoginAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Image.asset(
        kLogoPath,
        height: 40,
      ),
      actions: [
        TextButton(
          onPressed: () {},
          child: const Text(
            'Skip',
            style: TextStyle(
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ],
    );
  }
}
