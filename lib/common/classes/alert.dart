import 'package:flutter/material.dart';

class Alert {
  static void showAlert(BuildContext context, String content) {
    final snackBar = SnackBar(content: Text(content));
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }
}
