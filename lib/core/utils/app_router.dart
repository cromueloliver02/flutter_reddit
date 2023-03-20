import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../features/auth/presentation/cubits/cubits.dart';
import '../../features/auth/presentation/pages/pages.dart';
import '../../features/community/presentation/cubits/cubits.dart';
import '../../features/community/presentation/pages/pages.dart';
import '../../features/home/presentation/pages/pages.dart';
import '../../features/splash/presentation/pages/pages.dart';
import '../dependencies.dart';

class AppRouter {
  static final GoRouter router = GoRouter(
    initialLocation: AuthSplashPage.path,
    routes: <GoRoute>[
      GoRoute(
        path: AuthSplashPage.path,
        name: AuthSplashPage.name,
        builder: (ctx, state) => const AuthSplashPage(),
      ),
      GoRoute(
        path: InitSplashPage.path,
        name: InitSplashPage.name,
        builder: (ctx, state) => const InitSplashPage(),
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
                BlocProvider<CreateCommunityCubit>.value(
                  value: sl<CreateCommunityCubit>(),
                ),
                BlocProvider<CreateCommunityFormCubit>.value(
                  value: sl<CreateCommunityFormCubit>(),
                ),
              ],
              child: const CreateCommunityPage(),
            ),
          ),
          GoRoute(
            path: CommunityDetailsPage.path,
            name: CommunityDetailsPage.name,
            builder: (ctx, state) => BlocProvider<CommunityDetailsCubit>.value(
              value: sl<CommunityDetailsCubit>(),
              child: CommunityDetailsPage(
                communityId: state.params['communityId']!,
              ),
            ),
            routes: [
              GoRoute(
                path: ModeratorToolsPage.path,
                name: ModeratorToolsPage.name,
                builder: (ctx, state) => ModeratorToolsPage(
                  communityId: state.params['communityId']!,
                ),
                routes: [
                  GoRoute(
                    path: UpdateCommunityPage.path,
                    name: UpdateCommunityPage.name,
                    builder: (ctx, state) => MultiBlocProvider(
                      providers: [
                        BlocProvider<CommunityDetailsCubit>.value(
                          value: sl<CommunityDetailsCubit>(),
                        ),
                        BlocProvider<EditCommunityFormCubit>.value(
                          value: sl<EditCommunityFormCubit>(),
                        ),
                      ],
                      child: UpdateCommunityPage(
                        communityId: state.params['communityId']!,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    ],
  );
}
