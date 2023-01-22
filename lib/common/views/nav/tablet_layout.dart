import 'package:authenticator/common/classes/enums.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:authenticator/classes/settings.dart';
import 'package:authenticator/common/bloc/app/app_bloc.dart';
import 'package:authenticator/common/bloc/settings/settings_bloc.dart';
import 'package:authenticator/common/views/brightness_toggle.dart';
import 'package:authenticator/common/views/hover_container.dart';
import 'package:window_manager/window_manager.dart';

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
      NavigationRailDestination(
        icon: const Icon(
          Icons.cancel_outlined,
        ),
        selectedIcon: const Icon(
          Icons.cancel,
        ),
        label: Text(NavRailOptions.exit.title),
      ),
    ];
  }

  Widget getAppBarContent(
          SettingsBloc bloc, SettingsModel settings, bool isTemplate) =>
      FittedBox(
        alignment: Alignment.centerRight,
        clipBehavior: Clip.hardEdge,
        child: getContentByAlignment(bloc, settings),
      );

  Widget getContentByAlignment(SettingsBloc bloc, SettingsModel settings) {
    List<Widget> children = [];

    children.add(const BrightnessToggle());

    return Container(
      alignment: Alignment.centerRight,
      constraints: BoxConstraints(
        maxHeight: widget.toolBarHeight,
        maxWidth: double.infinity,
      ),
      height: widget.toolBarHeight,
      padding: const EdgeInsets.all(10.0),
      child: Wrap(
        spacing: 5.0,
        alignment: WrapAlignment.center,
        crossAxisAlignment: WrapCrossAlignment.center,
        children: children,
      ),
    );
  }

  void loadNavigationMapping(
    SettingsBloc bloc,
    SettingsModel settings,
  ) {
    routeNameToIndex.addAll({
      AppRoute.home.name: 0,
      AppRoute.addEntry.name: 1,
      AppRoute.settings.name: 2
    });

    for (var e in routeNameToIndex.entries) {
      navigationMapping.putIfAbsent(
        e.value,
        () => () => context.goNamed(e.key),
      );
    }

    navigationMapping.putIfAbsent(3, () => () => windowManager.close());
  }

  // Toolbar
  Widget getControls() {
    return Container(
      alignment: AlignmentDirectional.centerStart,
      padding: const EdgeInsets.all(15.0),
      height: widget.toolBarHeight,
      child: Wrap(
        spacing: 5.0,
        children: [
          GestureDetector(
            child: Tooltip(
              message: resizeText,
              child: HoverContainer.contained(
                size: 15.0,
                align: Alignment.center,
                hoverIcon: resizeText == 'Maximize'
                    ? Transform.rotate(
                        angle: 45,
                        child: const Icon(
                          Icons.unfold_more,
                          color: Colors.black,
                          size: 12.0,
                        ),
                      )
                    : Transform.rotate(
                        angle: 45,
                        child: const Icon(
                          Icons.unfold_less,
                          color: Colors.black,
                          size: 12.0,
                        ),
                      ),
                containerColor: Colors.green,
              ),
            ),
            onTap: () async => await windowManager.isMaximized()
                ? windowManager.restore()
                : windowManager.maximize(),
          ),
          GestureDetector(
            child: Tooltip(
              message: 'Minimize',
              child: HoverContainer.contained(
                size: 15.0,
                align: Alignment.center,
                hoverIcon: const Icon(
                  Icons.remove,
                  size: 12,
                  color: Colors.black,
                ),
                containerColor: Colors.amber,
              ),
            ),
            onTap: () async => windowManager.minimize(),
          ),
          GestureDetector(
            child: Tooltip(
              message: 'close',
              child: HoverContainer.contained(
                size: 15.0,
                align: Alignment.center,
                hoverIcon: const Icon(
                  Icons.close,
                  size: 12,
                  color: Colors.black,
                ),
                containerColor: Colors.red,
              ),
            ),
            onTap: () async => windowManager.close(),
          ),
        ],
      ),
    );
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
      if (mounted) {
        RouteInformation info =
            GoRouter.of(context).routeInformationProvider.value;
        final appBloc = BlocProvider.of<AppBloc>(context);
        if (info.location != null) {
          final name =
              info.location!.substring(info.location!.lastIndexOf("/") + 1);
          int? index = routeNameToIndex[name];
          if (index != null &&
              appBloc.state.selectedTabIndexNoMobile != index) {
            appBloc.add(AppEvent.setSelectedTabIndexNoMobile(index));
          }
        }
      }
    });
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      initListener();
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
            loadNavigationMapping(settingsBloc, settings);
            return Scaffold(
              appBar: AppBar(
                bottom: widget.bottom,
                leadingWidth: 100.0,
                leading: getControls(),
                centerTitle: true,
                title: Text(
                  widget.title,
                ),
                flexibleSpace: DragToMoveArea(
                  child: Container(),
                ),
                actions: [
                  getAppBarContent(settingsBloc, settings, true),
                ],
              ),
              floatingActionButtonLocation:
                  GoRouterState.of(context).location == AppRoute.home.path
                      ? FloatingActionButtonLocation.endFloat
                      : FloatingActionButtonLocation.startFloat,
              floatingActionButton: floatingAction(settingsBloc),
              body: SafeArea(
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    NavigationRail(
                      extended: widget.constraints.maxWidth >= 800,
                      minExtendedWidth: 150,
                      selectedIndex: appBloc.state.selectedTabIndexNoMobile,
                      onDestinationSelected: (int index) {
                        appBloc
                            .add(AppEvent.setSelectedTabIndexNoMobile(index));
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
