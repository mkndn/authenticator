import 'package:authenticator/common/classes/enums.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:authenticator/classes/settings.dart';
import 'package:authenticator/common/bloc/app/app_bloc.dart';
import 'package:authenticator/common/bloc/settings/settings_bloc.dart';
import 'package:authenticator/common/views/brightness_toggle.dart';

class TabletLayout extends StatefulWidget {
  const TabletLayout({
    required this.title,
    required this.child,
    required this.constraints,
    required this.parent,
    this.backButton = false,
    this.displayMenu = true,
    this.toolBarHeight = 50.0,
    this.bottom,
    super.key,
  });

  final String title;
  final String parent;
  final Widget child;
  final bool backButton;
  final double toolBarHeight;
  final bool displayMenu;
  final PreferredSizeWidget? bottom;
  final BoxConstraints constraints;

  @override
  State<TabletLayout> createState() => _TabletLayoutState();
}

class _TabletLayoutState extends State<TabletLayout> {
  String resizeText = 'Maximize';
  final Map<int, VoidCallback> navigationMapping = {};
  final Map<String, int> routeNameToIndex = {};

  List<NavigationRailDestination> getNavigationRailItems(
    SettingsBloc bloc,
    SettingsModel settings,
  ) {
    return [
      NavigationRailDestination(
        icon: const Icon(
          Icons.home_outlined,
        ),
        selectedIcon: const Icon(
          Icons.home,
        ),
        label: Text(NavRailOptions.home.title),
      ),
      NavigationRailDestination(
        icon: const Icon(
          Icons.add_circle_outline,
        ),
        selectedIcon: const Icon(
          Icons.add_circle,
        ),
        label: Text(NavRailOptions.add.title),
      ),
      NavigationRailDestination(
        icon: const Icon(Icons.settings_outlined),
        selectedIcon: const Icon(
          Icons.settings_outlined,
        ),
        label: Text(NavRailOptions.settings.title),
      ),
    ];
  }

  void loadNavigationMapping(
    SettingsBloc bloc,
    SettingsModel settings,
  ) {
    routeNameToIndex.addAll({
      AppRoute.home.name: 0,
      AppRoute.add.name: 1,
      AppRoute.settings.name: 2
    });

    for (var e in routeNameToIndex.entries) {
      navigationMapping.putIfAbsent(
        e.value,
        () => () => context.goNamed(e.key),
      );
    }
  }

  Widget? floatingAction(SettingsBloc settingsBloc) {
    if (GoRouterState.of(context).location == AppRoute.home.path) {
      return FloatingActionButton.small(
        onPressed: () {
          settingsBloc.add(
            SettingsEvent.updateTapToRevealState(
                !settingsBloc.state.display.tapToReveal),
          );
        },
        child: const Icon(Icons.visibility_off),
      );
    } else if (widget.backButton) {
      return FloatingActionButton.small(
        shape: const CircleBorder(),
        onPressed: () => context.goNamed(widget.parent),
        child: const Icon(Icons.chevron_left_outlined),
      );
    } else {
      return null;
    }
  }

  void initListener() {
    GoRouter.of(context).routeInformationProvider.addListener(() {
      selectIndexByRoute();
    });
  }

  void selectIndexByRoute() {
    if (mounted) {
      RouteInformation info =
          GoRouter.of(context).routeInformationProvider.value;
      final appBloc = BlocProvider.of<AppBloc>(context);
      if (info.location != null) {
        final fullPath =
            info.location!.substring(info.location!.lastIndexOf("/") + 1);
        final name = fullPath.indexOf("?") > 0
            ? fullPath.substring(0, fullPath.indexOf("?"))
            : fullPath;
        int? index = routeNameToIndex[name];
        if (index != null && appBloc.state.selectedSidebarItemIndex != index) {
          appBloc.add(AppEvent.setselectedSidebarItemIndex(index));
        }
      }
    }
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      initListener();
      selectIndexByRoute();
    });
  }

  @override
  Widget build(BuildContext context) {
    final settingsBloc = BlocProvider.of<SettingsBloc>(context);
    final appBloc = BlocProvider.of<AppBloc>(context);
    return BlocBuilder<AppBloc, AppState>(
      bloc: appBloc,
      builder: (builder, appState) {
        return BlocBuilder<SettingsBloc, SettingsState>(
          bloc: settingsBloc,
          builder: (builder, settingsState) {
            final settings =
                SettingsModel.fromStateJson(settingsState.toJson());
            if (widget.displayMenu) {
              loadNavigationMapping(settingsBloc, settings);
            }
            return Scaffold(
              appBar: AppBar(
                bottom: widget.bottom,
                centerTitle: true,
                title: Text(
                  widget.title,
                ),
                actions: const [BrightnessToggle()],
              ),
              floatingActionButtonLocation:
                  GoRouterState.of(context).location == AppRoute.home.path
                      ? FloatingActionButtonLocation.endFloat
                      : FloatingActionButtonLocation.startFloat,
              floatingActionButton:
                  widget.displayMenu ? floatingAction(settingsBloc) : null,
              body: SafeArea(
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    NavigationRail(
                      selectedIndex: appBloc.state.selectedSidebarItemIndex,
                      onDestinationSelected: (int index) {
                        appBloc
                            .add(AppEvent.setselectedSidebarItemIndex(index));
                        final navFunc = navigationMapping[index];
                        if (navFunc != null) navFunc();
                      },
                      destinations:
                          getNavigationRailItems(settingsBloc, settings),
                    ),
                    const VerticalDivider(thickness: 1, width: 1),
                    Expanded(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          OverflowBar(
                            spacing: 10.0,
                            children: [
                              Align(
                                alignment: Alignment.topCenter,
                                child: Padding(
                                  padding: const EdgeInsets.only(top: 15.0),
                                  child: widget.child,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        );
      },
    );
  }
}
