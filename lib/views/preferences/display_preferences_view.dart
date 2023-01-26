import 'package:authenticator/common/classes/enums.dart';
import 'package:authenticator/common/classes/extensions.dart';
import 'package:authenticator/common/classes/observables.dart';
import 'package:authenticator/common/dialogs/accent_picker.dart';
import 'package:authenticator/common/theme/theme_provider.dart';
import 'package:authenticator/common/theme/theme_settings.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:authenticator/classes/settings.dart';
import 'package:authenticator/common/bloc/settings/settings_bloc.dart';
import 'package:authenticator/common/views/settings_section.dart';
import 'package:authenticator/common/views/settings_tile.dart';
import 'package:authenticator/common/views/settings_view.dart';
import 'package:authenticator/services/preference_service.dart';

class DisplayPreferencesView extends StatefulWidget {
  const DisplayPreferencesView({super.key});

  @override
  State<DisplayPreferencesView> createState() => _DisplayPreferencesViewState();
}

class _DisplayPreferencesViewState extends State<DisplayPreferencesView> {
  final PreferenceService _preferenceService = PreferenceService.instance();

  @override
  Widget build(BuildContext context) {
    final settingsBloc = BlocProvider.of<SettingsBloc>(context);
    return BlocBuilder<SettingsBloc, SettingsState>(
      bloc: settingsBloc,
      builder: (builder, settingsState) {
        final settings = SettingsModel.fromStateJson(settingsState.toJson());
        return SettingsView(
          children: [
            SettingsSection(
              children: [
                SettingsTile(
                  leading: const [
                    Icon(
                      Icons.visibility_off_rounded,
                    ),
                  ],
                  trailing: [
                    Switch(
                      value: settings.display.tapToReveal,
                      onChanged: (value) async {
                        await _preferenceService.setTapToReveal(value);
                        settingsBloc
                            .add(SettingsEvent.updateTapToRevealState(value));
                      },
                    ),
                  ],
                  title: Text(
                    DisplaySettings.tapToReveal.title,
                  ),
                  subTitle: Padding(
                    padding: const EdgeInsets.only(top: 10.0),
                    child: Text(
                      settings.display.tapToReveal
                          ? 'TOTP codes are hidden'
                          : 'TOTP codes are visible',
                    ),
                  ),
                ),
                SettingsTile(
                  title: Text(
                    DisplaySettings.accentColor.title,
                  ),
                  subTitle: Padding(
                    padding: const EdgeInsets.only(top: 10.0),
                    child: Text(
                      ThemeProvider.of(context)
                          .settings
                          .value
                          .sourceColor
                          .title,
                    ),
                  ),
                  trailing: const [
                    Icon(
                      Icons.chevron_right,
                    )
                  ],
                  onTap: () async {
                    final AccentColor? selectedColor =
                        await AccentPicker.showCustomDialog(context);
                    if (mounted && selectedColor != null) {
                      final themeProvider = ThemeProvider.of(context);
                      final settings = themeProvider.settings.value;
                      final newSettings = ThemeSettings(
                        sourceColor: selectedColor,
                        themeMode: settings.themeMode,
                      );
                      ThemeSettingChange(settings: newSettings)
                          .dispatch(context);
                    }
                  },
                ),
                SettingsTile(
                  leading: const [
                    Icon(
                      Icons.brightness_auto_rounded,
                    ),
                  ],
                  trailing: [
                    Switch(
                      value: settings.display.autoBrightness,
                      onChanged: (value) async {
                        await _preferenceService.setAutoBrightness(value);
                        settingsBloc
                            .add(SettingsEvent.setAutoBrightness(value));
                      },
                    ),
                  ],
                  title: Text(
                    DisplaySettings.autoBrightness.title,
                  ),
                  subTitle: Padding(
                    padding: const EdgeInsets.only(top: 10.0),
                    child: Text(
                      settings.display.autoBrightness
                          ? 'App will change theme automatically based on your location'
                          : 'App theme is controlled by user',
                    ),
                  ),
                ),
              ],
            ),
          ],
        );
      },
    );
  }
}
