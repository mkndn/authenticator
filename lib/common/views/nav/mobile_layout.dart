import 'dart:io';

import 'package:authenticator/common/classes/enums.dart';
import 'package:authenticator/common/views/brightness_toggle.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:authenticator/classes/settings.dart';
import 'package:authenticator/common/bloc/app/app_bloc.dart';
import 'package:authenticator/common/bloc/settings/settings_bloc.dart';

class MobileLayout extends StatefulWidget {
  const MobileLayout({
    required this.title,
    required this.child,
    required this.parent,
    required this.constraints,
    this.backButton = false,
    this.bottom,
    super.key,
  });

  final String title;
  final String parent;
  final Widget child;
  final bool backButton;
  final PreferredSizeWidget? bottom;
  final BoxConstraints constraints;

  @override
  State<MobileLayout> createState() => _MobileLayoutState();
}

class _MobileLayoutState extends State<MobileLayout> with RouteAware {
  final Map<int, VoidCallback> navigationMapping = {};

  void loadNavigationMapping(
    SettingsBloc bloc,
    SettingsModel settings,
  ) {
    navigationMapping.addAll(
      <int, VoidCallback>{
        0: () => context.goNamed(AppRoute.home.name),
        1: () => context.goNamed(AppRoute.add.name),
        2: () => context.goNamed(AppRoute.settings.name),
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
              resizeToAvoidBottomInset: false,
              floatingActionButton: Wrap(
                direction: Axis.vertical,
                children: [
                  if (Platform.isAndroid || Platform.isIOS)
                    FloatingActionButton.small(
                      heroTag: 'totp_scan',
                      child: const Icon(Icons.qr_code_scanner_rounded),
                      onPressed: () {
                        context.goNamed(AppRoute.scan.name);
                      },
                    ),
                  const SizedBox(
                    height: 10.0,
                  ),
                  FloatingActionButton.small(
                    heroTag: 'totp_ttr',
                    child: Icon(settingsBloc.state.display.tapToReveal
                        ? Icons.visibility
                        : Icons.visibility_off),
                    onPressed: () {
                      settingsBloc.add(
                        SettingsEvent.updateTapToRevealState(
                            !settingsState.display.tapToReveal),
                      );
                    },
                  ),
                ],
              ),
              bottomNavigationBar: BottomNavigationBar(
                items: getBottomNavigation(),
                currentIndex: appBloc.state.selectedSidebarItemIndex,
                onTap: (int index) {
                  appBloc.add(AppEvent.setselectedSidebarItemIndex(index));
                  final navFunc = navigationMapping[index];
                  if (navFunc != null) navFunc();
                },
              ),
              appBar: AppBar(
                bottom: widget.bottom,
                centerTitle: true,
                leading: widget.backButton
                    ? IconButton(
                        icon: const Icon(
                          Icons.arrow_back,
                        ),
                        onPressed: () => context.goNamed(widget.parent),
                      )
                    : null,
                title: Text(
                  widget.title,
                ),
                actions: const [BrightnessToggle()],
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
