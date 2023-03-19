import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../../../../core/blocs/blocs.dart';
import '../../../../../core/utils/utils.dart';
import '../../../../home/presentation/pages/pages.dart';
import 'components/init_splash_view.dart';

class InitSplashPage extends StatefulWidget {
  const InitSplashPage({super.key});

  static const String name = 'init-splash';
  static const String path = '/$name';

  @override
  State<InitSplashPage> createState() => _InitSplashPageState();
}

class _InitSplashPageState extends State<InitSplashPage> {
  void _communityListListener(BuildContext ctx, CommunityListState state) {
    if (state.status == CommunityListStatus.success) {
      ctx.goNamed(HomePage.name);
    }

    if (state.status == CommunityListStatus.failure) {
      showErrorDialog(ctx, message: state.error.message);
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<CommunityListBloc, CommunityListState>(
      listenWhen: (prev, curr) => prev.status != curr.status,
      listener: _communityListListener,
      child: const InitSplashView(),
    );
  }

  // initilize app resources
  @override
  void initState() {
    super.initState();

    final String userId = context.read<AuthBloc>().state.user!.id;

    context
        .read<CommunityListBloc>()
        .add(CommunityListUserFetched(userId: userId));
  }
}
