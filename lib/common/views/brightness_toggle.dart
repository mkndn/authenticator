import 'dart:async';

import 'package:authenticator/common/bloc/settings/settings_bloc.dart';
import 'package:authenticator/common/classes/extensions.dart';
import 'package:authenticator/common/classes/observables.dart';
import 'package:authenticator/common/theme/theme_provider.dart';
import 'package:authenticator/common/theme/theme_settings.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class BrightnessToggle extends StatefulWidget {
  const BrightnessToggle({super.key});

  @override
  State<BrightnessToggle> createState() => _BrightnessToggleState();
}

class _BrightnessToggleState extends State<BrightnessToggle> {
  late SettingsState _state;
  bool shouldSelectTheme = false;

  void _selectTheme() {
    DateTime now = DateTime.now();
    ThemeMode modeByTime = ThemeMode.system;

    DateTime lightThemeSchedule = now.copyWith(hour: 7, minute: 0, second: 0);
    DateTime darkThemeSchedule = now.copyWith(hour: 19, minute: 0, second: 0);
    int nextTimer = 0;

    if (now.isAfter(lightThemeSchedule) && now.isBefore(darkThemeSchedule)) {
      modeByTime = ThemeMode.light;
      nextTimer = now.difference(darkThemeSchedule).inMilliseconds.abs();
    } else {
      modeByTime = ThemeMode.dark;
      nextTimer = now.difference(lightThemeSchedule).inMilliseconds.abs();
    }

    Timer(Duration(milliseconds: nextTimer), () {
      _selectTheme();
    });

    if (mounted) {
      dispatchThemeChange(modeByTime);
    }
  }

  void dispatchThemeChange(ThemeMode newMode) {
    final themeProvider = ThemeProvider.of(context);
    final settings = themeProvider.settings.value;
    if (newMode != ThemeMode.system && settings.themeMode != newMode) {
      final newSettings = ThemeSettings(
        sourceColor: settings.sourceColor,
        themeMode: newMode,
      );
      ThemeSettingChange(settings: newSettings).dispatch(context);
    }
  }

  @override
  void initState() {
    super.initState();
    _state = BlocProvider.of<SettingsBloc>(context).state;
  }

  @override
  Widget build(BuildContext context) {
    final SettingsBloc settingsBloc = BlocProvider.of<SettingsBloc>(context);
    return BlocBuilder<SettingsBloc, SettingsState>(
      bloc: settingsBloc,
      builder: (context, settingsState) {
        final themeProvider = ThemeProvider.of(context);
        final settings = themeProvider.settings.value;
        if (settingsState.display.autoBrightness) {
          if (!_state.display.autoBrightness) {
            _state = settingsState;
          }

          Future.delayed(const Duration(milliseconds: 500), _selectTheme);

          return const Padding(
            padding: EdgeInsets.only(right: 10.0),
            child: Icon(
              Icons.brightness_auto_rounded,
              size: 20.0,
            ),
          );
        } else if (_state.display.autoBrightness) {
          Future.delayed(const Duration(milliseconds: 500), () {
            final newSettings = ThemeSettings(
              sourceColor: settings.sourceColor,
              themeMode: ThemeMode.system,
            );
            ThemeSettingChange(settings: newSettings).dispatch(context);
          });
        }
        _state = settingsState;
        return IconButton(
          padding: const EdgeInsets.all(2.0),
          icon: !context.isDark
              ? const Icon(Icons.brightness_3)
              : const Icon(Icons.brightness_7),
          onPressed: () {
            final newSettings = ThemeSettings(
              sourceColor: settings.sourceColor,
              themeMode: context.isDark ? ThemeMode.light : ThemeMode.dark,
            );
            ThemeSettingChange(settings: newSettings).dispatch(context);
          },
        );
      },
    );
  }
}
