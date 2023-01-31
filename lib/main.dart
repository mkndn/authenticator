import 'dart:io' show Directory, Platform;
import 'package:authenticator/common/classes/adapters.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:authenticator/app.dart';
import 'package:authenticator/classes/totp_data.dart';
import 'package:home_widget/home_widget.dart';
// ignore: depend_on_referenced_packages
import 'package:path_provider/path_provider.dart';
import 'package:window_manager/window_manager.dart';
import 'package:workmanager/workmanager.dart';

/// Used for Background Updates using Workmanager Plugin
@pragma("vm:entry-point")
void callbackDispatcher() {
  Workmanager().executeTask((taskName, inputData) {
    return Future.wait<bool>([
      HomeWidget.saveWidgetData(
        'totpData',
        '123456,345678,901234',
      ).then((value) => value ?? false),
      HomeWidget.updateWidget(
        name: 'HomeWidgetExampleProvider',
        iOSName: 'HomeWidgetExample',
      ).then((value2) => value2 ?? false),
    ]).then((value) {
      return !value.contains(false);
    });
  });
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  //Workmanager().initialize(callbackDispatcher, isInDebugMode: kDebugMode);
  Hive
    ..init(Directory.current.path)
    ..registerAdapter(AlgorithmAdapter())
    ..registerAdapter(ObjectIdAdapter())
    ..registerAdapter(TotpDataAdapter())
    ..registerAdapter(OffsetAdapter());

  if (Platform.isWindows || Platform.isMacOS) {
    await Hive.openBox<TotpData>('totp_data',
        path: Directory.current.absolute.path);
    await windowManager.ensureInitialized();

    WindowOptions windowOptions = const WindowOptions(
      size: Size(1300, 600),
      minimumSize: Size(400, 600),
      center: true,
      backgroundColor: Colors.transparent,
      skipTaskbar: false,
      titleBarStyle: TitleBarStyle.hidden,
    );
    windowManager.waitUntilReadyToShow(windowOptions, () async {
      await windowManager.setResizable(true);
      await windowManager.show();
      await windowManager.focus();
    });
  } else {
    final appSupport = await getApplicationSupportDirectory();
    await Hive.openBox<TotpData>('totp_data', path: appSupport.path);
  }

  runApp(const MyApp());
}
