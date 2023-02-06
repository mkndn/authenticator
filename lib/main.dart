import 'dart:io' show Directory, Platform;
import 'package:authenticator/common/classes/adapters.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:authenticator/app.dart';
import 'package:authenticator/classes/totp_data.dart';
// ignore: depend_on_referenced_packages
import 'package:path_provider/path_provider.dart';
import 'package:window_manager/window_manager.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
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
