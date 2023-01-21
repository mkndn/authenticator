import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:authenticator/common/bloc/app/app_bloc.dart';

class SettingsGuard extends StatefulWidget {
  const SettingsGuard({required this.child, super.key});

  final Widget child;

  @override
  State<SettingsGuard> createState() => _SettingsGuardState();
}

class _SettingsGuardState extends State<SettingsGuard> {
  @override
  Widget build(BuildContext context) {
    final bloc = BlocProvider.of<AppBloc>(context);
    return BlocBuilder<AppBloc, AppState>(
        bloc: bloc,
        builder: (builder, state) {
          if (state.settingsLoaded) {
            return widget.child;
          }
          return const CircularProgressIndicator.adaptive();
        });
  }
}
