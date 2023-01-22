import 'package:authenticator/common/classes/enums.dart';
import 'package:authenticator/router.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:authenticator/common/views/settings_section.dart';
import 'package:authenticator/common/views/settings_tile.dart';
import 'package:authenticator/common/views/settings_view.dart';

class PreferencesView extends StatefulWidget {
  const PreferencesView({super.key});

  @override
  State<PreferencesView> createState() => _PreferencesViewState();
}

class _PreferencesViewState extends State<PreferencesView> {
  @override
  Widget build(BuildContext context) {
    return SettingsView(
      children: [
        SettingsSection(
          children: routes.values
              .where(
                (element) => element.parent?.name == AppRoute.settings.name,
              )
              .map((e) => SettingsTile(
                    leading: [
                      Icon(
                        e.route.icon,
                      )
                    ],
                    trailing: const [
                      Icon(
                        Icons.chevron_right,
                      )
                    ],
                    title: Text(
                      e.route.title,
                    ),
                    subTitle: Padding(
                      padding: const EdgeInsets.only(top: 10.0),
                      child: Text(
                        e.leaves.join(" . "),
                      ),
                    ),
                    onClick: () => context.goNamed(e.route.name),
                  ))
              .toList(),
        ),
      ],
    );
  }
}
