import 'package:go_router/go_router.dart';

import 'app_route_path.dart';
import 'routes.dart';

class AppRouteConf {
  GoRouter get router => _router;

  late final _router = GoRouter(
    initialLocation: AppRoute.test.path,
    debugLogDiagnostics: true,
    routes: [
      GoRoute(
        path: AppRoute.test.path,
        name: AppRoute.test.name,
        pageBuilder: (context, state) => NoTransitionPage(
          key: state.pageKey,
          child: const TestPage(),
        ),
      ),
    ],
  );
}
