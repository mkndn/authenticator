import 'package:authenticator/common/classes/enums.dart';

class RouteInfo {
  final AppRoute route;
  final AppRoute? parent;
  final List<String> leaves;

  RouteInfo({
    required this.route,
    this.parent,
    this.leaves = const [],
  });
}
