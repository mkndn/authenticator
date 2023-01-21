import 'package:authenticator/mixins/route_mixin.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:authenticator/classes/settings.dart';
import 'package:authenticator/common/bloc/app/app_bloc.dart';
import 'package:authenticator/common/bloc/settings/settings_bloc.dart';
import 'package:authenticator/common/enums.dart';
import 'package:authenticator/common/views/brightness_toggle.dart';
import 'package:authenticator/common/views/hover_container.dart';
import 'package:window_manager/window_manager.dart';

class DesktopNav extends StatefulWidget {
  const DesktopNav({
    required this.title,
    required this.child,
    required this.constraints,
    this.backButton = false,
    this.displayMenu = true,
    this.toolBarHeight = 50.0,
    this.bottom,
    super.key,
  });

  final String title;
  final Widget child;
  final bool backButton;
  final double toolBarHeight;
  final bool displayMenu;
  final PreferredSizeWidget? bottom;
  final BoxConstraints constraints;

  @override
  State<DesktopNav> createState() => _DesktopNavState();
}

class _DesktopNavState extends State<DesktopNav>
    with RouteMixin, WindowListener {
  String resizeText = 'Maximize';
  final Map<int, VoidCallback> navigationMapping = {};

  @override
  Future<void> onWindowEvent(String eventName) async {
    if (eventName == 'unmaximize') {
      resizeText = 'Maximize';
    }
    if (eventName == 'maximize') {
      resizeText = 'Restore';
    }
  }

  List<NavigationRailDestination> getNavigationRailItems(
    SettingsBloc bloc,
    SettingsModel settings,
  ) {
    List<NavigationRailDestination> sideBarItems = [];
    sideBarItems.addAll([
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
    ]);
    return sideBarItems;
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
    navigationMapping.addAll(
      <int, VoidCallback>{
        0: () => GoRouter.of(context).go(AppRoutes.home.path),
        1: () => GoRouter.of(context)
            .go("${AppRoutes.home.path}/${AppSubRoutes.addEntry.path}"),
        2: () => GoRouter.of(context)
            .go("${AppRoutes.home.path}/${AppSubRoutes.settings.path}"),
        3: () => windowManager.close()
      },
    );
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

  @override
  void initState() {
    super.initState();
    windowManager.addListener(this);
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
                  FloatingActionButtonLocation.startFloat,
              floatingActionButton: widget.backButton
                  ? FloatingActionButton.small(
                      shape: const CircleBorder(),
                      onPressed: () => GoRouter.of(context).go(
                        parent(GoRouterState.of(context)),
                      ),
                      child: const Icon(Icons.chevron_left_outlined),
                    )
                  : null,
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
