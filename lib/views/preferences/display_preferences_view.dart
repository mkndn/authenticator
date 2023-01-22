import 'dart:io';

import 'package:authenticator/common/classes/enums.dart';
import 'package:authenticator/common/classes/extensions.dart';
import 'package:authenticator/common/classes/observables.dart';
import 'package:authenticator/common/theme/theme_provider.dart';
import 'package:authenticator/common/theme/theme_settings.dart';
import 'package:flex_color_picker/flex_color_picker.dart';
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

  Future<Color> colorPickerDialog(Color currentColor) async {
    return showColorPickerDialog(
      context,
      currentColor,
      width: 25,
      height: 25,
      borderRadius: 50,
      spacing: 5,
      runSpacing: 5,
      wheelDiameter: 155,
      enableOpacity: true,
      colorCodeHasColor: true,
      heading: Text(
        'Select color',
        style: context.titleMedium,
      ),
      subheading: Text(
        'Select color shade',
        style: context.titleMedium,
      ),
      wheelSubheading: Text(
        'Selected color and its shades',
        style: context.titleMedium,
      ),
      showMaterialName: true,
      showColorName: true,
      showColorCode: true,
      copyPasteBehavior: const ColorPickerCopyPasteBehavior(
        copyButton: true,
        pasteButton: true,
        longPressMenu: true,
      ),
      actionButtons: const ColorPickerActionButtons(
        okButton: true,
        closeButton: true,
        dialogActionButtons: false,
      ),
      transitionBuilder: (
        BuildContext context,
        Animation<double> animation1,
        Animation<double> animation2,
        Widget widget,
      ) {
        final double curvedValue =
            Curves.easeInOutBack.transform(animation1.value) - 1.0;
        return Transform(
          transform: Matrix4.translationValues(0.0, curvedValue * 200, 0.0),
          child: Opacity(
            opacity: animation1.value,
            child: widget,
          ),
        );
      },
      transitionDuration: const Duration(milliseconds: 400),
      constraints: const BoxConstraints(
        minHeight: 480,
        minWidth: 320,
        maxWidth: 320,
      ),
      materialNameTextStyle: context.bodySmall,
      colorNameTextStyle: context.bodySmall,
      colorCodeTextStyle: context.bodyMedium,
      colorCodePrefixStyle: context.bodySmall,
      selectedPickerTypeColor: context.colors.primary,
      pickersEnabled: const <ColorPickerType, bool>{
        ColorPickerType.both: false,
        ColorPickerType.primary: true,
        ColorPickerType.accent: true,
        ColorPickerType.bw: false,
        ColorPickerType.custom: true,
        ColorPickerType.wheel: true,
      },
      customColorSwatchesAndNames: const {},
    );
  }

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
                    DisplaySettings.primaryColor.title,
                  ),
                  subTitle: Padding(
                    padding: const EdgeInsets.only(top: 10.0),
                    child: Text(
                      '#${ThemeProvider.of(context).settings.value.sourceColor.hex}',
                    ),
                  ),
                  trailing: const [
                    Icon(
                      Icons.chevron_right,
                    )
                  ],
                  leading: [
                    ColorIndicator(
                      width: 25,
                      height: 25,
                      borderRadius: 50,
                      color:
                          ThemeProvider.of(context).settings.value.sourceColor,
                      onSelectFocus: false,
                      onSelect: () async {
                        final Color newColor = await colorPickerDialog(
                          ThemeProvider.of(context).settings.value.sourceColor,
                        );
                        await _preferenceService
                            .setPrimaryColor(newColor.hexAlpha);
                        if (!mounted) return;
                        final newSettings = ThemeSettings(
                          sourceColor: newColor, // Replace this color
                          themeMode: ThemeMode.system,
                        );
                        ThemeSettingChange(settings: newSettings)
                            .dispatch(context);
                      },
                    ),
                  ],
                ),
              ],
            ),
          ],
        );
      },
    );
  }
}
