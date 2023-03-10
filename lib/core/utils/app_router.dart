import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../features/auth/presentation/cubits/cubits.dart';
import '../../features/auth/presentation/pages/pages.dart';
import '../../features/community/presentation/blocs/blocs.dart';
import '../../features/community/presentation/cubits/cubits.dart';
import '../../features/community/presentation/pages/pages.dart';
import '../../features/home/presentation/pages/pages.dart';
import '../dependencies.dart';

class AppRouter {
  static final GoRouter router = GoRouter(
    initialLocation: SplashPage.path,
    routes: <GoRoute>[
      GoRoute(
        path: SplashPage.path,
        name: SplashPage.name,
        builder: (ctx, state) => const SplashPage(),
      ),
      GoRoute(
        path: LoginPage.path,
        name: LoginPage.name,
        builder: (ctx, state) => BlocProvider<SignInCubit>.value(
          value: sl<SignInCubit>(),
          child: const LoginPage(),
        ),
      ),
      GoRoute(
        path: HomePage.path,
        name: HomePage.name,
        builder: (ctx, state) => const HomePage(),
        routes: [
          GoRoute(
            path: CreateCommunityPage.path,
            name: CreateCommunityPage.name,
            builder: (ctx, state) => MultiBlocProvider(
              providers: [
                BlocProvider<CommunityBloc>.value(value: sl<CommunityBloc>()),
                BlocProvider<CommunityFormCubit>.value(
                  value: sl<CommunityFormCubit>(),
                ),
              ],
              child: const CreateCommunityPage(),
            ),
          ),
        ],
      ),
    ],
  );
}
