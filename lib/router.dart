import 'dart:async';

import 'package:authenticator/views/qr_scanner.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:authenticator/common/bloc/app/app_bloc.dart';
import 'package:authenticator/common/enums.dart';
import 'package:authenticator/common/views/nav/app_title_bar.dart';
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

GoRouter appRouter(AppBloc bloc) => GoRouter(
      refreshListenable: bloc,
      initialLocation: AppRoutes.login.path,
      routes: [
        // LoginScreen
        GoRoute(
          path: AppRoutes.login.path,
          name: AppRoutes.login.name,
          pageBuilder: (context, state) => MaterialPage<void>(
            key: _pageKey,
            child: AppTitleBar(
              displayMenu: false,
              title: AppRoutes.login.title,
              child: const LoginView(),
            ),
          ),
        ),
        // HomeScreen
        GoRoute(
            path: AppRoutes.home.path,
            name: AppRoutes.home.name,
            pageBuilder: (context, state) => MaterialPage<void>(
                  key: _pageKey,
                  child: AppTitleBar(
                    title: AppRoutes.home.title,
                    child: const HomePage(),
                  ),
                ),
            routes: [
              GoRoute(
                path: AppSubRoutes.scan.path,
                name: AppSubRoutes.scan.name,
                pageBuilder: (context, state) => const MaterialPage<void>(
                  child: QRScanner(),
                ),
              ),
              GoRoute(
                path: AppSubRoutes.addEntry.path,
                name: AppSubRoutes.addEntry.name,
                pageBuilder: (context, state) => const MaterialPage<void>(
                  child: AddEntry(),
                ),
              ),
              GoRoute(
                path: AppSubRoutes.editEntry.path,
                name: AppSubRoutes.editEntry.name,
                pageBuilder: (context, state) => MaterialPage<void>(
                  child: EditEntry(
                    title: AppSubRoutes.editEntry.title,
                    entryId: state.params['eid']!,
                    embedded: false,
                  ),
                ),
              ),
              GoRoute(
                path: AppSubRoutes.settings.path,
                name: AppSubRoutes.settings.name,
                pageBuilder: (context, state) => const MaterialPage<void>(
                  child: PreferencesView(),
                ),
                routes: [
                  GoRoute(
                    path: SettingsSubRoutes.display.path,
                    name: SettingsSubRoutes.display.name,
                    pageBuilder: (context, state) => const MaterialPage<void>(
                      child: DisplayPreferencesView(),
                    ),
                  ),
                  GoRoute(
                    path: SettingsSubRoutes.security.path,
                    name: SettingsSubRoutes.security.name,
                    pageBuilder: (context, state) => const MaterialPage<void>(
                      child: SecuirtySettingsView(),
                    ),
                  ),
                  GoRoute(
                    path: SettingsSubRoutes.importExport.path,
                    name: SettingsSubRoutes.importExport.name,
                    pageBuilder: (context, state) => const MaterialPage<void>(
                      child: ImportExportSettingsView(),
                    ),
                  ),
                  GoRoute(
                    path: SettingsSubRoutes.data.path,
                    name: SettingsSubRoutes.data.name,
                    pageBuilder: (context, state) => const MaterialPage<void>(
                      child: DataSettingsView(),
                    ),
                  ),
                ],
              ),
            ]),
      ],
      redirect: (context, state) {
        String currentRoute = state.subloc;
        String loginRoute = AppRoutes.login.path;

        if (currentRoute == loginRoute) {
          if (bloc.state.authenticated || !bloc.state.hasCredentials) {
            return AppRoutes.home.path;
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
