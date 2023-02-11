import 'dart:convert';
import 'package:authenticator/classes/totp_data.dart';
import 'package:authenticator/classes/totp_widget_data.dart';
import 'package:authenticator/common/classes/extensions.dart';
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

  Future<void> updateData(BuildContext context, {TotpData? data}) async {
    await _sendData(
      context,
      data != null ? [data] : HiveService.instance().getAllItems(),
      true,
    );
    await _updateWidget();
  }

  Future<void> initData(BuildContext context) async {
    await _sendData(context, HiveService.instance().getAllItems(), false);
    await _updateWidget();
  }

  Future<void> _sendData(
      BuildContext context, List<TotpData> data, bool isUpdate) async {
    try {
      TotpWidgetData widgetData = TotpWidgetData(
        data: data,
        totalAccounts: data.length,
        bgColor: context.colors.primary.toHex(),
        textColor: context.textTheme.labelSmall!.color!.toHex(),
        isUpdateFlow: isUpdate,
      );
      HomeWidget.saveWidgetData("widgetData", jsonEncode(widgetData));
    } on PlatformException catch (e) {
      debugPrint('Error Sending Data. $e');
    }
  }
}
