import 'package:authenticator/common/classes/extensions.dart';
import 'package:authenticator/common/classes/observables.dart';
import 'package:authenticator/common/theme/theme_provider.dart';
import 'package:authenticator/common/theme/theme_settings.dart';
import 'package:flutter/material.dart';

class BrightnessToggle extends StatelessWidget {
  const BrightnessToggle({super.key});

  @override
  Widget build(BuildContext context) {
    return IconButton(
      padding: const EdgeInsets.all(2.0),
      icon: !context.isDark
          ? const Icon(Icons.brightness_3)
          : const Icon(Icons.brightness_7),
      onPressed: () {
        final themeProvider = ThemeProvider.of(context);
        final settings = themeProvider.settings.value;
        final newSettings = ThemeSettings(
          sourceColor: settings.sourceColor,
          themeMode: context.isDark ? ThemeMode.light : ThemeMode.dark,
        );
        ThemeSettingChange(settings: newSettings).dispatch(context);
      },
    );
  }
}
