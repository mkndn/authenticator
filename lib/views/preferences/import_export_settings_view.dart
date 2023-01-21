import 'package:authenticator/classes/settings.dart';
import 'package:authenticator/common/bloc/settings/settings_bloc.dart';
import 'package:flutter/material.dart';
import 'package:authenticator/common/enums.dart';
import 'package:authenticator/common/extensions.dart';
import 'package:authenticator/common/views/nav/app_title_bar.dart';
import 'package:authenticator/views/preferences/import_export_template.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ImportExportSettingsView extends StatefulWidget {
  const ImportExportSettingsView({super.key});

  @override
  State<ImportExportSettingsView> createState() =>
      _ImportExportSettingsViewState();
}

class _ImportExportSettingsViewState extends State<ImportExportSettingsView>
    with TickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    final settingsBloc = BlocProvider.of<SettingsBloc>(context);
    return BlocBuilder<SettingsBloc, SettingsState>(
      bloc: settingsBloc,
      builder: (builder, settingsState) {
        return LayoutBuilder(
          builder: (context, constraints) => AppTitleBar(
            backButton: true,
            backActionPath: AppSubRoutes.settings.path,
            title: SettingsSubRoutes.importExport.title,
            child: Column(
              children: [
                TabBar(
                  controller: _tabController,
                  tabs: [
                    Tab(
                      icon: Wrap(
                        spacing: 8.0,
                        alignment: WrapAlignment.center,
                        crossAxisAlignment: WrapCrossAlignment.center,
                        children: [
                          const Icon(
                            Icons.file_download_outlined,
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: 10.0),
                            child: Text(
                              ImportExportSettings.import.title,
                            ),
                          )
                        ],
                      ),
                    ),
                    Tab(
                      icon: Wrap(
                        spacing: 8.0,
                        alignment: WrapAlignment.center,
                        crossAxisAlignment: WrapCrossAlignment.center,
                        children: [
                          const Icon(
                            Icons.file_upload_outlined,
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: 10.0),
                            child: Text(
                              ImportExportSettings.export.title,
                            ),
                          )
                        ],
                      ),
                    ),
                  ],
                ),
                ConstrainedBox(
                  constraints: BoxConstraints(
                      maxWidth: constraints.maxWidth,
                      maxHeight: constraints.maxHeight * 0.5),
                  child: TabBarView(
                    controller: _tabController,
                    children: [
                      ImportExportTemplate(
                          mode: ImportExportSettings.import.title),
                      ImportExportTemplate(
                          mode: ImportExportSettings.export.title),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
