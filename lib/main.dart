import 'dart:io' show Directory, Platform;
import 'dart:ui';
import 'package:authenticator/common/classes/adapters.dart';
import 'package:bitsdojo_window/bitsdojo_window.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:authenticator/app.dart';
import 'package:authenticator/classes/totp_data.dart';
// ignore: depend_on_referenced_packages
import 'package:path_provider/path_provider.dart';

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

  if (Platform.isWindows || Platform.isMacOS) {
    doWhenWindowReady(() {
      final win = appWindow;
      const initialSize = Size(650, 600);
      win.minSize = initialSize;
      win.size = initialSize;
      win.alignment = Alignment.center;
      win.title = "Custom window with Flutter";
      win.show();
    });
  }

  runApp(const MyApp());
}
