import 'package:flutter/material.dart';

class RouteGuard {
  final Future<bool> Function(BuildContext, Object) guard;

  RouteGuard(this.guard);

  Future<bool> canActivate(BuildContext context, Object arguments) async {
    return guard(context, arguments);
  }
}
