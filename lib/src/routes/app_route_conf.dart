import 'package:go_router/go_router.dart';

import 'app_route_path.dart';
import 'routes.dart';

class AppRouteConf {
  GoRouter get router => _router;

  late final _router = GoRouter(
    initialLocation: AppRoute.editor.path,
    debugLogDiagnostics: true,
    routes: [
      GoRoute(
        path: AppRoute.editor.path,
        name: AppRoute.editor.name,
        pageBuilder: (context, state) => NoTransitionPage(
          key: state.pageKey,
          child: const EditorPage(),
        ),
      ),
      GoRoute(
        path: AppRoute.tree.path,
        name: AppRoute.tree.name,
        pageBuilder: (context, state) => NoTransitionPage(
          key: state.pageKey,
          child: const TreePage(),
        ),
      ),
    ],
  );
}
