import 'dart:async';

import 'package:authenticator/common/classes/enums.dart';
import 'package:authenticator/common/classes/route_config.dart';
import 'package:authenticator/views/qr_scanner.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:authenticator/common/bloc/app/app_bloc.dart';
import 'package:authenticator/common/views/nav/root_layout.dart';
import 'package:authenticator/views/add_entry.dart';
import 'package:authenticator/views/edit_entry.dart';
import 'package:authenticator/views/preferences/import_export_settings_view.dart';
import 'package:authenticator/views/home.dart';
import 'package:authenticator/views/login.dart';
import 'package:authenticator/views/preferences/data_settings_view.dart';
import 'package:authenticator/views/preferences/display_preferences_view.dart';
import 'package:authenticator/views/preferences/preferences_view.dart';
import 'package:authenticator/views/preferences/security_settings_view.dart';

const _pageKey = ValueKey("_pageKey");

class GoRouterRefreshStream extends ChangeNotifier {
  GoRouterRefreshStream(Stream<dynamic> stream) {
    notifyListeners();
    _subscription =
        stream.asBroadcastStream().listen((dynamic _) => notifyListeners());
  }

  late final StreamSubscription<dynamic> _subscription;

  @override
  void dispose() {
    _subscription.cancel();
    super.dispose();
  }
}

final Map<AppRoute, RouteInfo> routes = {
  AppRoute.login: RouteInfo(
    route: AppRoute.login,
  ),
  AppRoute.home: RouteInfo(
    route: AppRoute.home,
  ),
  AppRoute.scan: RouteInfo(
    route: AppRoute.scan,
    parent: AppRoute.home,
  ),
  AppRoute.editEntry: RouteInfo(
    route: AppRoute.editEntry,
    parent: AppRoute.home,
  ),
  AppRoute.addEntry: RouteInfo(
    route: AppRoute.addEntry,
    parent: AppRoute.home,
  ),
  AppRoute.settings: RouteInfo(
    route: AppRoute.settings,
    parent: AppRoute.home,
  ),
  AppRoute.display: RouteInfo(
      route: AppRoute.display,
      parent: AppRoute.settings,
      leaves: DisplaySettings.titles),
  AppRoute.security: RouteInfo(
      route: AppRoute.security,
      parent: AppRoute.settings,
      leaves: SecuritySettings.titles),
  AppRoute.importExport: RouteInfo(
      route: AppRoute.importExport,
      parent: AppRoute.settings,
      leaves: ImportExportSettings.titles),
  AppRoute.data: RouteInfo(
      route: AppRoute.data,
      parent: AppRoute.settings,
      leaves: DataSettings.titles),
};

GoRouter appRouter(AppBloc bloc) => GoRouter(
      refreshListenable: bloc,
      initialLocation: AppRoute.login.path,
      routes: [
        // LoginScreen
        GoRoute(
          path: AppRoute.login.path,
          name: AppRoute.login.name,
          pageBuilder: (context, state) => MaterialPage<void>(
            key: _pageKey,
            child: RootLayout(
              displayMenu: false,
              routeInfo: routes[AppRoute.login]!,
              title: AppRoute.login.title,
              child: const LoginView(),
            ),
          ),
        ),
        // HomeScreen
        GoRoute(
            path: AppRoute.home.path,
            name: AppRoute.home.name,
            pageBuilder: (context, state) => MaterialPage<void>(
                  key: _pageKey,
                  child: RootLayout(
                    routeInfo: routes[AppRoute.home]!,
                    title: AppRoute.home.title,
                    child: const HomeView(),
                  ),
                ),
            routes: [
              GoRoute(
                path: AppRoute.scan.path,
                name: AppRoute.scan.name,
                pageBuilder: (context, state) => const MaterialPage<void>(
                  child: QRScanner(),
                ),
              ),
              GoRoute(
                path: AppRoute.addEntry.path,
                name: AppRoute.addEntry.name,
                pageBuilder: (context, state) => MaterialPage<void>(
                  child: RootLayout(
                    routeInfo: routes[AppRoute.addEntry]!,
                    displayMenu: false,
                    title: "Add account",
                    backButton: true,
                    child: AddEntry(
                      initialValue: state.queryParams.containsKey('totpUrl')
                          ? state.queryParams['totpUrl']
                          : null,
                    ),
                  ),
                ),
              ),
              GoRoute(
                path: '${AppRoute.editEntry.path}/:eid',
                name: AppRoute.editEntry.name,
                pageBuilder: (context, state) => MaterialPage<void>(
                  child: RootLayout(
                    routeInfo: routes[AppRoute.editEntry]!,
                    displayMenu: false,
                    backButton: true,
                    title: AppRoute.editEntry.title,
                    child: EditEntry.standalone(
                      entryId: state.params['eid']!,
                    ),
                  ),
                ),
              ),
              GoRoute(
                path: AppRoute.settings.path,
                name: AppRoute.settings.name,
                pageBuilder: (context, state) => MaterialPage<void>(
                  child: RootLayout(
                    routeInfo: routes[AppRoute.settings]!,
                    backButton: true,
                    displayMenu: false,
                    title: AppRoute.settings.title,
                    child: const PreferencesView(),
                  ),
                ),
                routes: [
                  GoRoute(
                    path: AppRoute.display.path,
                    name: AppRoute.display.name,
                    pageBuilder: (context, state) => MaterialPage<void>(
                      child: RootLayout(
                        routeInfo: routes[AppRoute.display]!,
                        backButton: true,
                        title: AppRoute.display.title,
                        child: const DisplayPreferencesView(),
                      ),
                    ),
                  ),
                  GoRoute(
                    path: AppRoute.security.path,
                    name: AppRoute.security.name,
                    pageBuilder: (context, state) => MaterialPage<void>(
                      child: RootLayout(
                        routeInfo: routes[AppRoute.security]!,
                        backButton: true,
                        title: AppRoute.security.title,
                        child: const SecuirtySettingsView(),
                      ),
                    ),
                  ),
                  GoRoute(
                    path: AppRoute.importExport.path,
                    name: AppRoute.importExport.name,
                    pageBuilder: (context, state) => MaterialPage<void>(
                      child: RootLayout(
                        routeInfo: routes[AppRoute.importExport]!,
                        backButton: true,
                        title: AppRoute.importExport.title,
                        child: const ImportExportSettingsView(),
                      ),
                    ),
                  ),
                  GoRoute(
                    path: AppRoute.data.path,
                    name: AppRoute.data.name,
                    pageBuilder: (context, state) => MaterialPage<void>(
                      child: RootLayout(
                        routeInfo: routes[AppRoute.data]!,
                        backButton: true,
                        title: AppRoute.data.title,
                        child: const DataSettingsView(),
                      ),
                    ),
                  ),
                ],
              ),
            ]),
      ],
      redirect: (context, state) {
        String currentRoute = state.subloc;
        String loginRoute = AppRoute.login.path;

        if (currentRoute == loginRoute) {
          if (bloc.state.authenticated || !bloc.state.hasCredentials) {
            return AppRoute.home.path;
          }
          return null;
        } else {
          if (!bloc.state.authenticated && bloc.state.hasCredentials) {
            return loginRoute;
          }
          return null;
        }
      },
    );
