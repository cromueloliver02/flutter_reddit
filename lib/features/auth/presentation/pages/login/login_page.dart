import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../core/utils/utils.dart';
import '../../cubits/cubits.dart';
import 'components/login_view.dart';

class LoginPage extends StatelessWidget {
  static const String name = 'login';
  static const String path = '/$name';

  const LoginPage({super.key});

  void _signInListener(BuildContext ctx, SignInState state) {
    if (state.status == SignInStatus.failure) {
      showErrorDialog(ctx, message: state.error.message);
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<SignInCubit, SignInState>(
      listenWhen: (prev, curr) => prev.status != curr.status,
      listener: _signInListener,
      child: const LoginView(),
    );
  }
}
