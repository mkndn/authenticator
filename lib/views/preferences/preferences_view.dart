import 'package:authenticator/mixins/route_mixin.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:authenticator/common/enums.dart';
import 'package:authenticator/common/extensions.dart';
import 'package:authenticator/common/views/nav/app_title_bar.dart';
import 'package:authenticator/common/views/settings_section.dart';
import 'package:authenticator/common/views/settings_tile.dart';
import 'package:authenticator/common/views/settings_view.dart';

class PreferencesView extends StatefulWidget {
  const PreferencesView({super.key});

  @override
  State<PreferencesView> createState() => _PreferencesViewState();
}

class _PreferencesViewState extends State<PreferencesView> with RouteMixin {
  @override
  Widget build(BuildContext context) {
    return AppTitleBar(
      backButton: true,
      backActionPath: AppRoutes.home.path,
      displayMenu: false,
      title: AppSubRoutes.settings.title,
      child: SettingsView(
        children: [
          SettingsSection(
            children: SettingsSubRoutes.values
                .map((e) => SettingsTile(
                      leading: [
                        Icon(
                          e.icon,
                        )
                      ],
                      trailing: const [
                        Icon(
                          Icons.chevron_right,
                        )
                      ],
                      title: Text(
                        e.title,
                      ),
                      subTitle: Padding(
                        padding: const EdgeInsets.only(top: 10.0),
                        child: Text(
                          e.getLeaves().join(" . "),
                        ),
                      ),
                      onClick: () => GoRouter.of(context).go(
                        absolute(GoRouterState.of(context), e.path),
                      ),
                    ))
                .toList(),
          ),
        ],
      ),
    );
  }
}
