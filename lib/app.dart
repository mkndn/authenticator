import 'package:authenticator/common/classes/enums.dart';
import 'package:authenticator/common/classes/observables.dart';
import 'package:authenticator/common/theme/theme_provider.dart';
import 'package:authenticator/common/theme/theme_settings.dart';
import 'package:authenticator/common/views/custom_loading_indicator.dart';
import 'package:authenticator/services/authenticator_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:authenticator/classes/settings.dart';
import 'package:authenticator/common/bloc/app/app_bloc.dart';
import 'package:authenticator/common/bloc/settings/settings_bloc.dart';
import 'package:authenticator/services/auth/auth_service.dart';
import 'package:authenticator/services/preference_service.dart';
import 'package:home_widget/home_widget.dart';
import 'router.dart';
import 'package:dynamic_color/dynamic_color.dart';

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final PreferenceService _preferenceService = PreferenceService.instance();
  final AuthService _authService = AuthService.instance();
  final AuthenticatorWidget _authenticatorWidget =
      AuthenticatorWidget.instance();
  late final SettingsModel _appSettings;
  bool _settingsLoaded = false;
  List<String> _biometricsOptions = [];
  late final ValueNotifier<ThemeSettings> _settings;

  Future<void> loadBiometricsOptions() async {
    try {
      _biometricsOptions = (await _authService.getAvailableBiometrics())
          .map((e) => e.name)
          .toList();
    } on PlatformException catch (_) {
      _biometricsOptions = [];
    }
  }

  @override
  void initState() {
    super.initState();
    _authenticatorWidget.sendAndUpdate();
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      await loadBiometricsOptions();
      _appSettings = await _preferenceService.loadAllPreferences();
      setState(() {
        _settings = ValueNotifier(
          ThemeSettings(
            sourceColor: AccentColor.fromId(
                _appSettings.display.accentColorIndex), // Replace this color
            themeMode: ThemeMode.system,
          ),
        );
        _settingsLoaded = true;
      });
    });
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _authenticatorWidget.checkForWidgetLaunch();
    HomeWidget.widgetClicked.listen(_authenticatorWidget.launchedFromWidget);
  }

  @override
  Widget build(BuildContext context) {
    if (_settingsLoaded) {
      final appBloc = AppBloc(
        settingsLoaded: true,
        hasCredentials: _appSettings.hasCredentials,
        availableBiometricsList: _biometricsOptions,
      );
      return NotificationListener<ThemeSettingChange>(
        onNotification: (notification) {
          _settings.value = notification.settings;
          return true;
        },
        child: DynamicColorBuilder(
          builder: (lightDynamic, darkDynamic) => ThemeProvider(
            lightDynamic: lightDynamic,
            darkDynamic: darkDynamic,
            settings: _settings,
            child: ValueListenableBuilder<ThemeSettings>(
              valueListenable: _settings,
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
                  theme: theme.light(_settings.value.sourceColor.color),
                  // Add dark theme
                  darkTheme: theme.dark(_settings.value.sourceColor.color),
                  // Add theme mode
                  themeMode: theme.themeMode(),
                  routeInformationParser: routerInfo.routeInformationParser,
                  routeInformationProvider: routerInfo.routeInformationProvider,
                  routerDelegate: routerInfo.routerDelegate,
                  builder: (context, child) => BlocProvider<AppBloc>(
                    create: (context) => appBloc,
                    child: BlocProvider<SettingsBloc>(
                      create: (context) => SettingsBloc(_appSettings),
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
