import 'package:authenticator/common/classes/enums.dart';
import 'package:flutter/material.dart';

class ThemeSettings {
  ThemeSettings({
    required this.sourceColor,
    required this.themeMode,
  });

  final AccentColor sourceColor;
  final ThemeMode themeMode;
}
