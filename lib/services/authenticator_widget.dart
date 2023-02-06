import 'dart:convert';
import 'package:authenticator/services/hive_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:home_widget/home_widget.dart';

class AuthenticatorWidget {
  static AuthenticatorWidget? _instance;

  AuthenticatorWidget._();

  static AuthenticatorWidget instance() {
    _instance ??= AuthenticatorWidget._();
    return _instance!;
  }

  void checkForWidgetLaunch() {
    HomeWidget.initiallyLaunchedFromHomeWidget().then(launchedFromWidget);
  }

  void launchedFromWidget(Uri? uri) {
    if (uri != null) {
      debugPrint(uri.toString());
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
      return HomeWidget.saveWidgetData<String>(
          'totpData', jsonEncode(HiveService.instance().getAllItems()));
    } on PlatformException catch (e) {
      debugPrint('Error Sending Data. $e');
    }
  }

  Future<void> sendAndUpdate() async {
    await _sendData();
    await _updateWidget();
  }

  Future<void> sendNext(String id, String code) async {
    try {
      HomeWidget.saveWidgetData<String>(id, code);
    } on PlatformException catch (e) {
      debugPrint('Error Sending Data. $e');
    }
    _updateWidget();
  }
}
