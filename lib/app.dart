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
import 'package:home_widget/home_widget.dart';
import 'package:workmanager/workmanager.dart';
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

  _updateWidget() async {
    try {
      return HomeWidget.updateWidget(
          name: 'AuthenticatorWidgetProvider',
          androidName: 'AuthenticatorWidgetProvider',
          qualifiedAndroidName:
              'com.mkndn.authenticator.widget.AuthenticatorWidgetProvider');
    } on PlatformException catch (e) {
      debugPrint('Error Updating Widget. $e');
    }
  }

  _sendData() async {
    try {
      final List<String> totpData = [
        '123456',
        '789101',
        '987654',
      ];
      return HomeWidget.saveWidgetData<String>('totpData', totpData.join(','));
    } on PlatformException catch (e) {
      debugPrint('Error Sending Data. $e');
    }
  }

  Future<void> _sendAndUpdate() async {
    await _sendData();
    await _updateWidget();
  }

  void _checkForWidgetLaunch() {
    HomeWidget.initiallyLaunchedFromHomeWidget().then(_launchedFromWidget);
  }

  void _startBackgroundUpdate() {
    Workmanager().registerPeriodicTask('1', 'widgetBackgroundUpdate',
        frequency: const Duration(minutes: 15));
  }

  void _stopBackgroundUpdate() {
    Workmanager().cancelByUniqueName('1');
  }

  void _launchedFromWidget(Uri? uri) {
    if (uri != null) {
      showDialog(
          context: context,
          builder: (context) => AlertDialog(
                title: const Text('App started from widget'),
                content: Text('The url from Widget: $uri'),
              ));
    }
  }

  /// Called when Doing Background Work initiated from Widget
  @pragma("vm:entry-point")
  static void backgroundCallback(Uri? data) async {
    debugPrint(data?.toString());
    final List<String> totpData = [
      '123456',
      '789101',
      '987654',
    ];
    await HomeWidget.saveWidgetData<String>('totpData', totpData.join(','));
    await HomeWidget.updateWidget(
        name: 'AuthenticatorWidgetProvider',
        androidName: 'AuthenticatorWidgetProvider',
        qualifiedAndroidName:
            'com.mkndn.authenticator.widget.AuthenticatorWidgetProvider');
  }

  @override
  void initState() {
    super.initState();
    _sendAndUpdate();
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      //await HomeWidget.setAppGroupId('group.com.mkndn.authenticator');
      //await HomeWidget.registerBackgroundCallback(backgroundCallback);
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
  void didChangeDependencies() {
    super.didChangeDependencies();
    _checkForWidgetLaunch();
    HomeWidget.widgetClicked.listen(_launchedFromWidget);
  }

  @override
  void dispose() {
    super.dispose();
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
          return true;
        },
        child: DynamicColorBuilder(
          builder: (lightDynamic, darkDynamic) => ThemeProvider(
            lightDynamic: lightDynamic,
            darkDynamic: darkDynamic,
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
