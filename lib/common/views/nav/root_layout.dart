import 'package:authenticator/common/classes/enums.dart';
import 'package:authenticator/common/classes/extensions.dart';
import 'package:authenticator/common/classes/route_config.dart';
import 'package:flutter/material.dart';
import 'package:authenticator/common/views/nav/desktop_layout.dart';
import 'package:authenticator/common/views/nav/mobile_layout.dart';
import 'package:authenticator/common/views/nav/tablet_layout.dart';
import 'package:authenticator/services/preference_service.dart';

class RootLayout extends StatefulWidget {
  const RootLayout({
    required this.title,
    required this.child,
    required this.routeInfo,
    this.bottom,
    this.displayMenu = true,
    this.backButton = false,
    this.toolBarHeight = 50.0,
    super.key,
  });

  final String title;
  final Widget child;
  final PreferredSizeWidget? bottom;
  final bool displayMenu;
  final double toolBarHeight;
  final bool backButton;
  final RouteInfo routeInfo;

  @override
  State<RootLayout> createState() => _RootLayoutState();
}

class _RootLayoutState extends State<RootLayout> {
  final PreferenceService preferenceService = PreferenceService.instance();
  Alignment toolbarAlignment = Alignment.center;
  double containerWidth = 0.0;
  double containerHeight = 0.0;

  String get parentRouteName =>
      widget.routeInfo.parent?.name ?? AppRoute.home.name;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constraints) {
      if (constraints.isDesktop) {
        return SafeArea(
          child: DesktopLayout(
            title: widget.title,
            parent: parentRouteName,
            constraints: constraints,
            bottom: widget.bottom,
            backButton: widget.backButton,
            toolBarHeight: widget.toolBarHeight,
            child: widget.child,
          ),
        );
      } else if (constraints.isTablet) {
        return SafeArea(
          child: TabletLayout(
            title: widget.title,
            parent: parentRouteName,
            constraints: constraints,
            bottom: widget.bottom,
            backButton: widget.backButton,
            toolBarHeight: widget.toolBarHeight,
            child: widget.child,
          ),
        );
      } else if (constraints.isMobile) {
        return SafeArea(
          child: MobileLayout(
            title: widget.title,
            parent: parentRouteName,
            bottom: widget.bottom,
            backButton: widget.backButton,
            constraints: constraints,
            child: widget.child,
          ),
        );
      } else {
        return const Text('Device not supported');
      }
    });
  }
}
