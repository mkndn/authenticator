import 'package:flutter/material.dart';
import 'package:authenticator/common/extensions.dart';
import 'package:authenticator/common/views/nav/desktop_nav.dart';
import 'package:authenticator/common/views/nav/mobile_nav.dart';
import 'package:authenticator/common/views/nav/tablet_nav.dart';
import 'package:authenticator/services/preference_service.dart';

class AppTitleBar extends StatefulWidget {
  const AppTitleBar({
    required this.title,
    required this.child,
    this.bottom,
    this.displayMenu = true,
    this.backButton = false,
    this.backActionPath,
    this.toolBarHeight = 50.0,
    super.key,
  });

  final String title;
  final Widget child;
  final PreferredSizeWidget? bottom;
  final bool displayMenu;
  final String? backActionPath;
  final double toolBarHeight;
  final bool backButton;

  @override
  State<AppTitleBar> createState() => _AppTitleBarState();
}

class _AppTitleBarState extends State<AppTitleBar> {
  final PreferenceService preferenceService = PreferenceService.instance();
  Alignment toolbarAlignment = Alignment.center;
  double containerWidth = 0.0;
  double containerHeight = 0.0;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constraints) {
      if (constraints.isDesktop) {
        return DesktopNav(
          title: widget.title,
          constraints: constraints,
          bottom: widget.bottom,
          backButton: widget.backButton,
          toolBarHeight: widget.toolBarHeight,
          child: widget.child,
        );
      } else if (constraints.isTablet) {
        return const TabletNav();
      } else if (constraints.isMobile) {
        return MobileNav(
          title: widget.title,
          bottom: widget.bottom,
          backButton: widget.backButton,
          constraints: constraints,
          child: widget.child,
        );
      } else {
        return const Text('Device not supported');
      }
    });
  }
}
