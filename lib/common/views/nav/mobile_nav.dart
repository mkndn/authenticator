import 'dart:io';

import 'package:authenticator/mixins/route_mixin.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:authenticator/classes/settings.dart';
import 'package:authenticator/common/bloc/app/app_bloc.dart';
import 'package:authenticator/common/bloc/settings/settings_bloc.dart';
import 'package:authenticator/common/enums.dart';

class MobileNav extends StatefulWidget {
  const MobileNav({
    required this.title,
    required this.child,
    required this.constraints,
    this.backButton = false,
    this.bottom,
    super.key,
  });

  final String title;
  final Widget child;
  final bool backButton;
  final PreferredSizeWidget? bottom;
  final BoxConstraints constraints;

  @override
  State<MobileNav> createState() => _MobileNavState();
}

class _MobileNavState extends State<MobileNav> with RouteMixin {
  final Map<int, VoidCallback> navigationMapping = {};

  void loadNavigationMapping(
    SettingsBloc bloc,
    SettingsModel settings,
  ) {
    navigationMapping.addAll(
      <int, VoidCallback>{
        0: () => GoRouter.of(context).go(AppRoutes.home.path),
        1: () => GoRouter.of(context).go(
            absolute(GoRouterState.of(context), AppSubRoutes.addEntry.path)),
        2: () => GoRouter.of(context).go(
            absolute(GoRouterState.of(context), AppSubRoutes.settings.path)),
      },
    );
  }

  List<BottomNavigationBarItem> getBottomNavigation() {
    return [
      BottomNavigationBarItem(
        icon: const Icon(Icons.home),
        label: NavRailOptions.home.title,
      ),
      BottomNavigationBarItem(
        icon: const Icon(Icons.add),
        label: NavRailOptions.add.title,
      ),
      BottomNavigationBarItem(
        icon: const Icon(Icons.settings),
        label: NavRailOptions.settings.title,
      ),
    ];
  }

  void showBottonSheetContent(
      SettingsBloc settingsBloc, SettingsState settingsState) {
    showModalBottomSheet<void>(
      context: context,
      builder: (BuildContext context) {
        return SizedBox(
          height: 200,
          child: Center(
            child: ListView(
              children: [
                if (Platform.isAndroid || Platform.isIOS)
                  ListTile(
                    leading: const Icon(Icons.qr_code_scanner),
                    title: Text(MenuOptions.scan.optionName),
                    onTap: () {
                      GoRouter.of(context).go(absolute(
                          GoRouterState.of(context), AppSubRoutes.scan.path));
                      Navigator.pop(context);
                    },
                  ),
                ListTile(
                    leading: const Icon(Icons.security_rounded),
                    title: Text(
                      settingsState.display.tapToReveal
                          ? MenuOptions.revealDisable.optionName
                          : MenuOptions.revealEnable.optionName,
                    ),
                    onTap: () {
                      settingsBloc.add(
                        SettingsEvent.updateTapToRevealState(
                            !settingsState.display.tapToReveal),
                      );
                      Navigator.pop(context);
                    })
              ],
            ),
          ),
        );
      },
    );
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
              floatingActionButton: FloatingActionButton(
                child: const Icon(Icons.keyboard_arrow_up),
                onPressed: () =>
                    showBottonSheetContent(settingsBloc, settingsState),
              ),
              bottomNavigationBar: BottomNavigationBar(
                items: getBottomNavigation(),
                currentIndex: appBloc.state.selectedTabIndexNoMobile,
                onTap: (int index) {
                  appBloc.add(AppEvent.setSelectedTabIndexNoMobile(index));
                  final navFunc = navigationMapping[index];
                  if (navFunc != null) navFunc();
                },
              ),
              appBar: AppBar(
                bottom: widget.bottom,
                centerTitle: true,
                leading: widget.backButton
                    ? CircleAvatar(
                        child: IconButton(
                          icon: const Icon(
                            Icons.arrow_back,
                            size: 16,
                          ),
                          onPressed: () => GoRouter.of(context).go(
                            parent(GoRouterState.of(context)),
                          ),
                        ),
                      )
                    : null,
                title: Text(
                  widget.title,
                ),
              ),
              body: SizedBox(
                height: widget.constraints.maxHeight,
                child: Align(
                  alignment: Alignment.topCenter,
                  child: widget.child,
                ),
              ),
            );
          },
        );
      },
    );
  }
}
