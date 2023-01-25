import 'package:authenticator/common/classes/alert.dart';
import 'package:authenticator/common/classes/enums.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:authenticator/classes/settings.dart';
import 'package:authenticator/common/bloc/settings/settings_bloc.dart';
import 'package:authenticator/common/views/settings_section.dart';
import 'package:authenticator/common/views/settings_tile.dart';
import 'package:authenticator/common/views/settings_view.dart';
import 'package:authenticator/services/hive_service.dart';
import 'package:authenticator/services/preference_service.dart';

class DataSettingsView extends StatefulWidget {
  const DataSettingsView({super.key});

  @override
  State<DataSettingsView> createState() => _DataSettingsViewState();
}

class _DataSettingsViewState extends State<DataSettingsView> {
  final PreferenceService _preferenceService = PreferenceService.instance();

  List<SettingsTile> getDataOptions(SettingsModel settings) {
    List<SettingsTile> children = [];
    children.addAll(
      [
        SettingsTile(
          leading: const [
            Icon(
              Icons.delete_rounded,
            ),
          ],
          trailing: const [
            Icon(
              Icons.chevron_right_rounded,
            ),
          ],
          onTap: () async => await _preferenceService.reset().whenComplete(
                () => Alert.showAlert(context, 'Cache cleared successfully'),
              ),
          title: Text(
            DataSettings.clearCache.title,
          ),
          subTitle: const Padding(
            padding: EdgeInsets.only(top: 10.0),
            child: Text(
              'Clears app settings and configuration',
            ),
          ),
        ),
        SettingsTile(
          leading: const [
            Icon(
              Icons.folder_delete_rounded,
            ),
          ],
          trailing: const [
            Icon(
              Icons.chevron_right_rounded,
            ),
          ],
          onTap: () {
            setState(() {
              HiveService.instance().reset();
            });
            Alert.showAlert(context, 'Cache data successfully');
          },
          title: Text(
            DataSettings.clearData.title,
          ),
          subTitle: const Padding(
            padding: EdgeInsets.only(top: 10.0),
            child: Text(
              'Deletes all TOTP codes configured',
            ),
          ),
        ),
      ],
    );

    return children;
  }

  Widget getWarningContent() {
    return Card(
      shape: RoundedRectangleBorder(
        side: const BorderSide(width: 0.75),
        borderRadius: BorderRadius.circular(10.0),
      ),
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: const [
            Text(
              'Caution!',
              style: TextStyle(
                color: Colors.red,
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(
              'Careful before you proceed with any of the options below as it will affect your app configuration and data',
              softWrap: true,
            ),
          ],
        ),
      ),
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
              sectionSubHeader: getWarningContent(),
              children: getDataOptions(settings),
            ),
          ],
        );
      },
    );
  }
}
