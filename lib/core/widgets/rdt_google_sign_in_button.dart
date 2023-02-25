import 'package:flutter/material.dart';

import '../constants/constants.dart';
import '../utils/utils.dart';

class RDTGoogleSignInButton extends StatelessWidget {
  final VoidCallback onPressed;

  const RDTGoogleSignInButton({
    super.key,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton.icon(
      onPressed: onPressed,
      icon: Image.asset(kGoogleLogoPath, width: 35),
      label: const Text(
        'Continue with Google',
        style: TextStyle(fontSize: 18),
      ),
      style: ElevatedButton.styleFrom(
        backgroundColor: AppTheme.greyColor,
        minimumSize: const Size(double.infinity, 50),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      ),
    );
  }
}
