import 'package:authenticator/common/classes/enums.dart';
import 'package:authenticator/common/classes/observables.dart';
import 'package:authenticator/common/theme/theme_provider.dart';
import 'package:authenticator/common/theme/theme_settings.dart';
import 'package:authenticator/common/views/custom_loading_indicator.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:authenticator/classes/settings.dart';
import 'package:authenticator/common/bloc/app/app_bloc.dart';
import 'package:authenticator/common/bloc/settings/settings_bloc.dart';
import 'package:authenticator/services/auth/auth_service.dart';
import 'package:authenticator/services/preference_service.dart';
import 'router.dart';
import 'package:dynamic_color/dynamic_color.dart';

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final PreferenceService _preferenceService = PreferenceService.instance();
  final AuthService authService = AuthService.instance();
  late final SettingsModel appSettings;
  bool settingsLoaded = false;
  List<String> biometricsOptions = [];
  AppBloc? appBloc;
  late final ValueNotifier<ThemeSettings> settings;

  Future<void> loadBiometricsOptions() async {
    try {
      biometricsOptions = (await authService.getAvailableBiometrics())
          .map((e) => e.name)
          .toList();
    } on PlatformException catch (_) {
      biometricsOptions = [];
    }
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      await loadBiometricsOptions();
      appSettings = await _preferenceService.loadAllPreferences();
      setState(() {
        settings = ValueNotifier(
          ThemeSettings(
            sourceColor: AccentColor.fromId(
                appSettings.display.accentColorIndex), // Replace this color
            themeMode: ThemeMode.system,
          ),
        );
        settingsLoaded = true;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    if (settingsLoaded) {
      final appBloc = AppBloc(
        settingsLoaded: true,
        hasCredentials: appSettings.hasCredentials,
        availableBiometricsList: biometricsOptions,
      );
      return NotificationListener<ThemeSettingChange>(
        onNotification: (notification) {
          settings.value = notification.settings;
          appSettings.display.accentColorIndex = settings.value.sourceColor.id;
          return true;
        },
        child: DynamicColorBuilder(
          builder: (lightDynamic, darkDynamic) => ThemeProvider(
            lightDynamic:
                appSettings.display.accentColorIndex == 1 ? lightDynamic : null,
            darkDynamic:
                appSettings.display.accentColorIndex == 1 ? darkDynamic : null,
            settings: settings,
            child: ValueListenableBuilder<ThemeSettings>(
              valueListenable: settings,
              builder: (context, value, _) {
                // Create theme instance
                final routerInfo = appRouter(appBloc);
                final theme = ThemeProvider.of(context);
                return MaterialApp.router(
                  scrollBehavior: ScrollConfiguration.of(context)
                      .copyWith(scrollbars: false),
                  debugShowCheckedModeBanner: false,
                  title: 'Authenticator',
                  // Add theme
                  theme: theme.light(settings.value.sourceColor.color),
                  // Add dark theme
                  darkTheme: theme.dark(settings.value.sourceColor.color),
                  // Add theme mode
                  themeMode: theme.themeMode(),
                  routeInformationParser: routerInfo.routeInformationParser,
                  routeInformationProvider: routerInfo.routeInformationProvider,
                  routerDelegate: routerInfo.routerDelegate,
                  builder: (context, child) => BlocProvider<AppBloc>(
                    create: (context) => appBloc,
                    child: BlocProvider<SettingsBloc>(
                      create: (context) => SettingsBloc(appSettings),
                      child: child,
                    ),
                  ),
                );
              },
            ),
          ),
        ),
      );
    } else {
      return const CustomLoadingIndicator();
    }
  }
}
