import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../../../../core/blocs/blocs.dart';
import '../../../../../core/utils/utils.dart';
import '../../../../community/presentation/blocs/blocs.dart';
import '../../../../home/presentation/pages/pages.dart';
import '../../blocs/blocs.dart';
import 'components/init_splash_view.dart';

class InitSplashPage extends StatefulWidget {
  static const String name = 'init-splash';
  static const String path = '/$name';

  const InitSplashPage({super.key});

  @override
  State<InitSplashPage> createState() => _InitSplashPageState();
}

class _InitSplashPageState extends State<InitSplashPage> {
  void _communityListener(BuildContext ctx, CommunityState state) {
    if (state.loadStatus == CommunityLoadStatus.success) {
      ctx.goNamed(HomePage.name);
    }

    if (state.loadStatus == CommunityLoadStatus.failure) {
      showErrorDialog(ctx, message: state.error.message);
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<CommunityBlocImpl, CommunityState>(
      listenWhen: (prev, curr) => prev.loadStatus != curr.loadStatus,
      listener: _communityListener,
      child: const InitSplashView(),
    );
  }

  // initilize app resources
  @override
  void initState() {
    super.initState();

    final String userId = context.read<AuthBlocImpl>().state.user!.id;

    context
        .read<CommunityBlocImpl>()
        .add(CommunityUserGetRequested(userId: userId));
  }
}