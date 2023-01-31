import 'package:authenticator/common/classes/alert.dart';
import 'package:authenticator/common/classes/enums.dart';
import 'package:authenticator/common/classes/extensions.dart';
import 'package:authenticator/common/views/custom_loading_indicator.dart';
import 'package:authenticator/common/views/pin_input.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:local_auth/local_auth.dart';
import 'package:authenticator/classes/settings.dart';
import 'package:authenticator/common/bloc/app/app_bloc.dart';
import 'package:authenticator/common/bloc/settings/settings_bloc.dart';
import 'package:authenticator/services/secured_storage.dart';
import 'package:authenticator/services/auth/auth_service.dart';

class LoginView extends StatefulWidget {
  const LoginView({super.key});

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  final AuthService authService = AuthService.instance();
  final SecureStorage _secureStorage = SecureStorage.instance();
  final GlobalKey<FormState> _passwordForm = GlobalKey<FormState>();
  final GlobalKey<FormState> _pinForm = GlobalKey<FormState>();
  late AppBloc appBloc;
  late SettingsModel settings;
  Map<LoginOptions, Widget> options = <LoginOptions, Widget>{};

  void getLoginOptions(SettingsModel settings) {
    if (settings.hasFingerPrint()) {
      options.putIfAbsent(
          LoginOptions.fingerprint,
          () => ListTile(
                mouseCursor: MaterialStateMouseCursor.clickable,
                shape: const ContinuousRectangleBorder(),
                title: const Text(
                  'Fingerprint',
                ),
                leading: const Icon(
                  Icons.fingerprint,
                  size: 20.0,
                ),
                trailing: const Icon(
                  Icons.arrow_forward_ios_outlined,
                  size: 16.0,
                ),
                onTap: () async {
                  appBloc.add(const AppEvent.setAuthenticated(true));
                  bool isAuthenticated = await authService.authenticate(
                    localizedReason: 'Let OS determine authentication method',
                    options: const AuthenticationOptions(
                      stickyAuth: true,
                    ),
                  );
                  appBloc.add(AppEvent.setAuthenticated(isAuthenticated));
                },
              ));
    }

    if (settings.hasPassword()) {
      options.putIfAbsent(
        LoginOptions.password,
        () => ListTile(
          mouseCursor: MaterialStateMouseCursor.clickable,
          title: const Text(
            'Password',
          ),
          leading: const Icon(
            Icons.password,
            size: 20.0,
          ),
          trailing: const Icon(
            Icons.arrow_forward_ios_outlined,
            size: 16.0,
          ),
          onTap: () async {
            appBloc.add(const AppEvent.setAuthenticated(true));
            bool isAuthenticated = await _passwordDialog() ?? false;
            appBloc.add(AppEvent.setAuthenticated(isAuthenticated));
          },
        ),
      );
    }

    if (settings.hasPin()) {
      options.putIfAbsent(
        LoginOptions.pin,
        () => ListTile(
          mouseCursor: MaterialStateMouseCursor.clickable,
          shape: const ContinuousRectangleBorder(),
          title: const Text(
            'PIN',
          ),
          leading: const Icon(
            Icons.pin,
            size: 20.0,
          ),
          trailing: const Icon(
            Icons.arrow_forward_ios_outlined,
            size: 16.0,
          ),
          onTap: () async {
            appBloc.add(const AppEvent.isAuthenticating(true));
            bool isAuthenticated = await _pinDialog() ?? false;
            appBloc.add(AppEvent.setAuthenticated(isAuthenticated));
          },
        ),
      );
    }
  }

  Future<bool?> _pinDialog() async {
    final pinController = TextEditingController();

    return showDialog<bool>(
      barrierDismissible: false,
      context: context,
      builder: (BuildContext context) => FutureBuilder(
        future: _secureStorage.getPin(),
        builder: (builder, snapshot) => AlertDialog(
          clipBehavior: Clip.antiAlias,
          scrollable: false,
          title: Text('Pin', style: context.titleMedium),
          content: Form(
            autovalidateMode: AutovalidateMode.disabled,
            key: _pinForm,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                SizedBox(
                  width: 300.0,
                  height: 100.0,
                  child: PinInput(
                    controller: pinController,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter your old pin';
                      }

                      if (value != snapshot.data) {
                        pinController.clear();
                        return 'Old pin is incorrect';
                      }
                      return null;
                    },
                    onComplete: (value) {},
                  ),
                ),
                OverflowBar(
                  spacing: 8.0,
                  children: [
                    ElevatedButton(
                      onPressed: () async {
                        if (_pinForm.currentState!.validate()) {
                          pinController.clear();
                          pinController.dispose();
                          Navigator.of(context).pop(true);
                        }
                      },
                      child: const Text('Submit'),
                    ),
                    ElevatedButton(
                      onPressed: () {
                        pinController.clear();
                        pinController.dispose();
                        Navigator.of(context).pop(false);
                      },
                      child: const Text('Close'),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<bool?> _passwordDialog() async {
    final passwordFieldController = TextEditingController();
    final passKey = GlobalKey<FormFieldState>();

    return showDialog<bool>(
      barrierDismissible: false,
      context: context,
      builder: (BuildContext context) => FutureBuilder(
        future: _secureStorage.getPassWord(),
        builder: (builder, snapshot) => AlertDialog(
          title: const Text('Password'),
          content: Form(
            key: _passwordForm,
            child: SizedBox(
              height: 200.0,
              child: Column(
                mainAxisSize: MainAxisSize.max,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    flex: 1,
                    child: TextFormField(
                      key: passKey,
                      obscureText: true,
                      controller: passwordFieldController,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          passwordFieldController.clear();
                          return 'Please enter your current password';
                        }
                        if (value != snapshot.data) {
                          return 'Password invalid. Please try again';
                        }
                        return null;
                      },
                    ),
                  ),
                  OverflowBar(
                    spacing: 8,
                    alignment: MainAxisAlignment.end,
                    children: [
                      ElevatedButton(
                        onPressed: () async {
                          if (_passwordForm.currentState!.validate()) {
                            passwordFieldController.clear();
                            Alert.showAlert(context, 'Login successful');
                            Navigator.of(context).pop(true);
                          }
                        },
                        child: const Text('Submit'),
                      ),
                      ElevatedButton(
                        onPressed: () {
                          passwordFieldController.clear();
                          Navigator.of(context).pop(false);
                        },
                        child: const Text('Close'),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Future<void> triggerAvailable() async {
    final entry = options.entries.first;
    if (mounted) {
      switch (entry.key) {
        case LoginOptions.fingerprint:
          appBloc.add(const AppEvent.isAuthenticating(true));
          bool isAuthenticated = await authService.authenticate(
            localizedReason: 'Let OS determine authentication method',
            options: const AuthenticationOptions(
              stickyAuth: true,
            ),
          );
          appBloc.add(AppEvent.setAuthenticated(isAuthenticated));
          break;
        case LoginOptions.password:
          appBloc.add(const AppEvent.isAuthenticating(true));
          bool isAuthenticated = await _passwordDialog() ?? false;
          appBloc.add(AppEvent.setAuthenticated(isAuthenticated));
          break;
        case LoginOptions.pin:
          appBloc.add(const AppEvent.isAuthenticating(true));
          bool isAuthenticated = await _pinDialog() ?? false;
          appBloc.add(AppEvent.setAuthenticated(isAuthenticated));
          break;
      }
    }
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (mounted && options.isNotEmpty) {
        triggerAvailable();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    appBloc = BlocProvider.of<AppBloc>(context);

    return LayoutBuilder(
      builder: (builder, constraints) {
        if (!appBloc.state.isAuthenticating && !appBloc.state.authenticated) {
          final settingsBloc = BlocProvider.of<SettingsBloc>(context);
          return Scaffold(
            body: BlocBuilder<AppBloc, AppState>(
              bloc: appBloc,
              builder: (context, appState) {
                return BlocBuilder<SettingsBloc, SettingsState>(
                  bloc: settingsBloc,
                  builder: (context, settingsState) {
                    settings =
                        SettingsModel.fromStateJson(settingsState.toJson());
                    getLoginOptions(settings);
                    return Container(
                      height: constraints.maxHeight,
                      alignment: AlignmentDirectional.center,
                      child: OverflowBar(
                        spacing: 8,
                        alignment: MainAxisAlignment.center,
                        overflowAlignment: OverflowBarAlignment.center,
                        children: [
                          const Text(
                            'Please select one of the options to login',
                          ),
                          ListView(
                            shrinkWrap: true,
                            padding: const EdgeInsets.all(15.0),
                            children: options.values.toList(),
                          ),
                        ],
                      ),
                    );
                  },
                );
              },
            ),
          );
        } else {
          return const CustomLoadingIndicator();
        }
      },
    );
  }
}
