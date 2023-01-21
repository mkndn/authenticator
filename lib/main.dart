import 'dart:io' show Directory, Platform;
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:authenticator/app.dart';
import 'package:authenticator/classes/totp_data.dart';
import 'package:window_manager/window_manager.dart';
// ignore: depend_on_referenced_packages
import 'package:path_provider/path_provider.dart';

import 'common/adapters.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  Hive
    ..init(Directory.current.path)
    ..registerAdapter(AlgorithmAdapter())
    ..registerAdapter(ObjectIdAdapter())
    ..registerAdapter(TotpDataAdapter())
    ..registerAdapter(OffsetAdapter());

  final appDir = await getApplicationDocumentsDirectory();
  await Hive.openBox<TotpData>('totp_data', path: appDir.path);

  if (Platform.isWindows) {
    await windowManager.ensureInitialized();
    WindowOptions windowOptions = const WindowOptions(
      size: Size(1400, 600),
      center: true,
      backgroundColor: Colors.transparent,
      skipTaskbar: false,
      titleBarStyle: TitleBarStyle.hidden,
    );
    windowManager.waitUntilReadyToShow(windowOptions, () async {
      await windowManager.show();
      await windowManager.focus();
    });
  }
  runApp(const MyApp());
}
