import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:authenticator/common/bloc/settings/settings_bloc.dart';
import 'package:authenticator/services/hive_service.dart';
import 'package:authenticator/classes/settings.dart';
import 'package:authenticator/classes/totp_data.dart';
import 'package:authenticator/views/totp_layout.dart';

class HomeView extends StatefulWidget {
  const HomeView({this.reload = false, super.key});

  final bool reload;

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  final HiveService _hiveService = HiveService.instance();
  final List<TotpData> data = List.empty(growable: true);

  void loadData() {
    data.clear();
    data.addAll(_hiveService.getAllItems());
  }

  @override
  Widget build(BuildContext context) {
    final settingsBloc = BlocProvider.of<SettingsBloc>(context);
    return BlocBuilder<SettingsBloc, SettingsState>(
      bloc: settingsBloc,
      builder: (builder, settingState) {
        loadData();
        return SingleChildScrollView(
          clipBehavior: Clip.antiAliasWithSaveLayer,
          child: data.isNotEmpty
              ? Container(
                  padding: const EdgeInsets.all(5.0),
                  constraints: BoxConstraints(
                    maxWidth: MediaQuery.of(context).size.width * 0.75,
                    maxHeight: MediaQuery.of(context).size.height * 0.75,
                  ),
                  child: ListView.builder(
                    shrinkWrap: true,
                    itemCount: data.length,
                    itemBuilder: (context, index) {
                      return Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          TotpLayout(
                            data: data[index],
                            onDelete: (id) => setState(
                              () => data
                                  .removeWhere((element) => element.id == id),
                            ),
                            settings: SettingsModel.fromStateJson(
                                settingState.toJson()),
                          ),
                          if (index < data.length - 1)
                            const Divider(
                              thickness: 0.3,
                            ),
                        ],
                      );
                    },
                  ),
                )
              : SizedBox(
                  width: MediaQuery.of(context).size.width * 0.75,
                  height: MediaQuery.of(context).size.height * 0.75,
                  child: const Align(
                    alignment: AlignmentDirectional.center,
                    child: Text('No accounts found'),
                  ),
                ),
        );
      },
    );
  }
}
