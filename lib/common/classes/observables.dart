import 'package:authenticator/common/theme/theme_settings.dart';
import 'package:flutter/material.dart';

class ThemeSettingChange extends Notification {
  ThemeSettingChange({required this.settings});
  final ThemeSettings settings;
}
