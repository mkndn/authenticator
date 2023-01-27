import 'package:authenticator/mixins/size_mixin.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:authenticator/common/bloc/settings/settings_bloc.dart';
import 'package:authenticator/services/hive_service.dart';
import 'package:authenticator/classes/settings.dart';
import 'package:authenticator/classes/totp_data.dart';
import 'package:authenticator/views/totp_layout.dart';

class HomeView extends StatefulWidget {
  const HomeView({this.reload = 'false', super.key});

  final String reload;

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> with SizeMixin {
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
        final settings = SettingsModel.fromStateJson(settingState.toJson());
        return LayoutBuilder(
          builder: (context, constraints) => data.isNotEmpty
              ? Container(
                  padding: const EdgeInsets.all(5.0),
                  constraints: BoxConstraints(
                    maxWidth: maxWidth(constraints,
                        offsetPercent: 0.7, offsetPercentMobile: 0.9),
                    maxHeight: maxHeight(constraints, offsetPercent: 0.7),
                  ),
                  child: getGridContent(constraints, settings),
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

  Widget getGridContent(BoxConstraints constraints, SettingsModel settings) {
    return GridView.builder(
      primary: false,
      padding: const EdgeInsets.all(20),
      shrinkWrap: true,
      gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
        maxCrossAxisExtent: 800.0,
        mainAxisExtent: 150.0,
        mainAxisSpacing: 5.0,
        crossAxisSpacing: 10.0,
      ),
      itemCount: data.length,
      itemBuilder: (context, index) => FittedBox(
        fit: BoxFit.scaleDown,
        child: TotpLayout(
          data: data[index],
          onDelete: (id) => setState(
            () => data.removeWhere((element) => element.id == id),
          ),
          settings: settings,
        ),
      ),
    );
  }

  Widget getListViewContent(SettingsModel settings) {
    return ListView.builder(
      shrinkWrap: true,
      itemCount: data.length,
      itemBuilder: (context, index) {
        return Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TotpLayout(
              data: data[index],
              onDelete: (id) => setState(
                () => data.removeWhere((element) => element.id == id),
              ),
              settings: settings,
            ),
            if (index < data.length - 1)
              const Divider(
                thickness: 0.3,
              ),
          ],
        );
      },
    );
  }
}
