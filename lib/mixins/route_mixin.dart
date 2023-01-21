import 'package:go_router/go_router.dart';

mixin RouteMixin {
  String parent(GoRouterState state) {
    final currentUrl = Uri.parse(state.location);
    final path = currentUrl.pathSegments
        .take(currentUrl.pathSegments.length - 1)
        .join("/");
    return '/$path';
  }

  String absolute(GoRouterState state, String childPath) {
    final currentUrl = Uri.parse(state.location);
    return '${currentUrl.path}/$childPath';
  }
}
