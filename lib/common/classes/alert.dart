import 'package:flutter/material.dart';

class Alert {
  static void showAlert(BuildContext context, String content, {double? width}) {
    final snackBar = SnackBar(
      content: Center(child: Text(content)),
      width: width,
      behavior: width != null ? SnackBarBehavior.floating : null,
    );
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }
}
