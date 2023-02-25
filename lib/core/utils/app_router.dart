import 'package:go_router/go_router.dart';

import '../../features/auth/presentation/pages/pages.dart';
import '../../features/home/presentation/pages/pages.dart';

class AppRouter {
  static final GoRouter router = GoRouter(
    initialLocation: '/login',
    routes: <GoRoute>[
      HomePage.route,
      LoginPage.route,
    ],
  );
}
