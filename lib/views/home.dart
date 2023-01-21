import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:authenticator/common/bloc/settings/settings_bloc.dart';
import 'package:authenticator/services/hive_service.dart';
import 'package:authenticator/services/preference_service.dart';
import 'package:authenticator/classes/settings.dart';
import 'package:authenticator/classes/totp_data.dart';
import 'package:authenticator/views/totp_layout.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final PreferenceService preferenceService = PreferenceService.instance();
  final HiveService service = HiveService.instance();
  final List<TotpData> data = List.empty(growable: true);
  TextStyle fontStyle = const TextStyle(
    letterSpacing: 2.0,
    fontSize: 16.0,
  );
  TextStyle titleFont = const TextStyle(
    letterSpacing: 2.0,
    fontSize: 18.0,
  );
  Color accentColor = Colors.white;

  void loadData() {
    data.addAll(service.getAllItems());
  }

  @override
  void initState() {
    super.initState();
    loadData();
  }

  @override
  Widget build(BuildContext context) {
    final settingsBloc = BlocProvider.of<SettingsBloc>(context);
    return BlocBuilder<SettingsBloc, SettingsState>(
      bloc: settingsBloc,
      builder: (builder, settingState) {
        return LayoutBuilder(
          builder: (builder, constraints) => SingleChildScrollView(
            clipBehavior: Clip.antiAliasWithSaveLayer,
            child: Container(
              padding: const EdgeInsets.all(5.0),
              constraints: BoxConstraints(
                maxWidth: constraints.maxWidth * 0.9,
                maxHeight: constraints.maxHeight,
              ),
              child: data.isNotEmpty
                  ? ListView.builder(
                      shrinkWrap: true,
                      itemCount: data.length,
                      itemBuilder: (context, index) {
                        return Column(
                          children: [
                            TotpLayout(
                              data: data[index],
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
                    )
                  : const Center(
                      child: Text.rich(
                        TextSpan(children: [
                          TextSpan(text: 'Press '),
                          WidgetSpan(
                              child: Icon(
                            Icons.menu,
                            size: 18,
                          )),
                          TextSpan(text: ' to add account')
                        ]),
                        textAlign: TextAlign.center,
                      ),
                    ),
            ),
          ),
        );
      },
    );
  }
}
