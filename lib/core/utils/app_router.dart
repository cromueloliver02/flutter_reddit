import 'package:go_router/go_router.dart';

import '../../features/home/presentation/pages/pages.dart';

class AppRouter {
  static final GoRouter router = GoRouter(
    routes: <GoRoute>[
      HomePage.route,
    ],
  );
}
