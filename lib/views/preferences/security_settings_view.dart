import 'package:authenticator/common/classes/alert.dart';
import 'package:authenticator/common/classes/enums.dart';
import 'package:authenticator/common/classes/extensions.dart';
import 'package:authenticator/common/views/pin_input.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:local_auth/local_auth.dart';
import 'package:authenticator/classes/settings.dart';
import 'package:authenticator/common/bloc/app/app_bloc.dart';
import 'package:authenticator/common/bloc/settings/settings_bloc.dart';
import 'package:authenticator/common/views/settings_section.dart';
import 'package:authenticator/common/views/settings_tile.dart';
import 'package:authenticator/common/views/settings_view.dart';
import 'package:authenticator/mixins/security_mixin.dart';
import 'package:authenticator/services/auth/auth_service.dart';
import 'package:authenticator/services/preference_service.dart';
import 'package:authenticator/services/secured_storage.dart';

class SecuirtySettingsView extends StatefulWidget {
  const SecuirtySettingsView({super.key});

  @override
  State<SecuirtySettingsView> createState() => _SecuirtySettingsViewState();
}

class _SecuirtySettingsViewState extends State<SecuirtySettingsView>
    with SecurityMixin {
  final PreferenceService _preferenceService = PreferenceService.instance();
  final SecureStorage secureStorage = SecureStorage.instance();
  final AuthService authService = AuthService.instance();
  final GlobalKey<FormState> _passwordForm = GlobalKey<FormState>();
  final GlobalKey<FormState> _pinForm = GlobalKey<FormState>();
  List<String> _availableBiometrics = [];

  Future<void> _authenticate(SettingsBloc bloc, SettingsModel settings) async {
    bool authenticated = false;
    try {
      authenticated = await authService.authenticate(
        localizedReason: 'Let OS determine authentication method',
        options: const AuthenticationOptions(
          stickyAuth: true,
        ),
      );
    } on PlatformException catch (_) {
      return;
    }
    if (!mounted) {
      return;
    }

    setState(() {
      if (authenticated) {
        _preferenceService.setFingerprint(authenticated);
        bloc.add(const SettingsEvent.updateFingerPrintState(true));
      }
    });
  }

  Future<void> _authenticateWithBiometrics(
      SettingsBloc bloc, SettingsModel settings) async {
    bool authenticated = false;
    try {
      authenticated = await authService.authenticate(
        localizedReason:
            'Scan your fingerprint (or face or whatever) to authenticate',
        options: const AuthenticationOptions(
          stickyAuth: true,
          biometricOnly: true,
        ),
      );
    } on PlatformException catch (_) {
      return;
    }
    if (!mounted) {
      return;
    }

    setState(() {
      if (authenticated) {
        _preferenceService.setFingerprint(true);
        bloc.add(const SettingsEvent.updateFingerPrintState(true));
      }
    });
  }

  List<SettingsTile> getSecurityOptions(
    BoxConstraints constraints,
    SettingsBloc bloc,
    SettingsModel settings,
  ) {
    List<SettingsTile> children = [];

    if (_availableBiometrics.contains(BiometricType.strong.name) ||
        _availableBiometrics.contains(BiometricType.fingerprint.name)) {
      children.add(
        SettingsTile(
          leading: const [
            Icon(
              Icons.fingerprint,
            )
          ],
          trailing: [
            Switch(
              value: settings.security.fingerPrint,
              onChanged: (value) async {
                if (value) {
                  constraints.isDesktop
                      ? await _authenticate(bloc, settings)
                      : await _authenticateWithBiometrics(bloc, settings);
                }
                await _preferenceService.setFingerprint(value);
                bloc.add(SettingsEvent.updateFingerPrintState(value));
              },
            ),
          ],
          title: Text(
            SecuritySettings.fingerprint.title,
          ),
          subTitle: Wrap(
            direction: Axis.vertical,
            children: [
              const Padding(
                padding: EdgeInsets.only(top: 10.0),
                child: Text(
                  'Strong security',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.green,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 10.0),
                child: Text(
                  settings.security.fingerPrint
                      ? 'You will be prompted to login with your Fingerprint upon restart'
                      : 'Fingerprint is disabled',
                ),
              ),
            ],
          ),
        ),
      );
    }

    children.addAll([
      SettingsTile(
        title: Text(
          settings.hasPassword()
              ? 'Reset ${SecuritySettings.password.title}'
              : 'Setup ${SecuritySettings.password.title}',
        ),
        subTitle: Wrap(
          direction: Axis.vertical,
          children: [
            const Padding(
              padding: EdgeInsets.only(top: 10.0),
              child: Text(
                'Medium security',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.amber,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 10.0),
              child: Text(
                settings.security.hasPassword
                    ? 'You will be prompted to login with your password upon restart'
                    : 'Password is not set',
              ),
            ),
          ],
        ),
        leading: const [
          Icon(
            Icons.password,
          ),
        ],
        trailing: [
          settings.hasPassword()
              ? ElevatedButton(
                  onPressed: () async {
                    await _preferenceService.removePassword();
                    bloc.add(const SettingsEvent.updatePasswordState(false));
                  },
                  child: const Text('Clear'),
                )
              : const Icon(
                  Icons.chevron_right_rounded,
                ),
        ],
        onClick: () => settings.hasPassword()
            ? _passwordDialog(bloc, settings, isCreate: false)
            : _passwordDialog(bloc, settings),
      ),
      SettingsTile(
        title: Text(
          settings.hasPin()
              ? 'Reset ${SecuritySettings.pin.title}'
              : 'Setup ${SecuritySettings.pin.title}',
        ),
        subTitle: Wrap(
          direction: Axis.vertical,
          children: [
            const Padding(
              padding: EdgeInsets.only(top: 10.0),
              child: Text(
                'Weak security',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.red,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 10.0),
              child: Text(
                settings.security.hasPin
                    ? 'You will be prompted to login with your PIN upon restart'
                    : 'PIN is not set',
              ),
            ),
          ],
        ),
        leading: const [
          Icon(
            Icons.pin,
          ),
        ],
        trailing: [
          settings.hasPin()
              ? ElevatedButton(
                  onPressed: () async {
                    await _preferenceService.removePin();
                    bloc.add(const SettingsEvent.updatePinState(false));
                  },
                  child: const Text('Clear'),
                )
              : const Icon(
                  Icons.chevron_right_rounded,
                ),
        ],
        onClick: () => settings.hasPin()
            ? _pinDialog(bloc, settings, isCreate: false)
            : _pinDialog(bloc, settings),
      ),
    ]);

    return children;
  }

  Future<void> _passwordDialog(
    SettingsBloc bloc,
    SettingsModel settings, {
    bool isCreate = true,
  }) async {
    final oldPasswordFieldController = TextEditingController();
    final newPasswordFieldController = TextEditingController();
    final confirmPasswordFieldController = TextEditingController();

    return showDialog<void>(
      barrierDismissible: false,
      context: context,
      builder: (BuildContext context) => FutureBuilder(
        future: secureStorage.getPassWord(),
        builder: (builder, snapshot) => AlertDialog(
          title: isCreate
              ? const Text('Setup Password')
              : const Text('Reset Password'),
          content: Form(
            key: _passwordForm,
            child: SizedBox(
              height: 200.0,
              child: Column(
                mainAxisSize: MainAxisSize.max,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  if (!isCreate)
                    Expanded(
                      flex: 1,
                      child: TextFormField(
                        obscureText: true,
                        controller: oldPasswordFieldController,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            oldPasswordFieldController.clear();
                            return 'Please enter your current password';
                          }

                          if (value != snapshot.data) {
                            return 'Old password is incorrect';
                          }
                          return null;
                        },
                      ),
                    ),
                  Expanded(
                    flex: 1,
                    child: TextFormField(
                      obscureText: true,
                      controller: newPasswordFieldController,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Password is required';
                        }
                        if (!meetsRequirement(value)) {
                          return 'Please enter a valid password. Password should contain letters, numbers and symbols';
                        }
                        return null;
                      },
                    ),
                  ),
                  Expanded(
                    flex: 1,
                    child: TextFormField(
                      obscureText: true,
                      controller: confirmPasswordFieldController,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          confirmPasswordFieldController.clear();
                          newPasswordFieldController.clear();
                          return 'Confirm password is missing';
                        }
                        if (newPasswordFieldController.text != value) {
                          confirmPasswordFieldController.clear();
                          newPasswordFieldController.clear();
                          return 'New password and confirm password don\'t match';
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
                            await secureStorage
                                .setPassWord(newPasswordFieldController.text);
                            await _preferenceService.setPassword(true);
                            newPasswordFieldController.clear();
                            confirmPasswordFieldController.clear();
                            oldPasswordFieldController.clear();
                            bloc.add(
                                const SettingsEvent.updatePasswordState(true));
                            if (!mounted) return;
                            confirmPasswordFieldController.dispose();
                            oldPasswordFieldController.dispose();
                            newPasswordFieldController.dispose();
                            Navigator.of(context).pop();
                            Alert.showAlert(
                                context, 'App password set successfully');
                          }
                        },
                        child: const Text('Submit'),
                      ),
                      ElevatedButton(
                        onPressed: () {
                          newPasswordFieldController.clear();
                          confirmPasswordFieldController.clear();
                          oldPasswordFieldController.clear();
                          confirmPasswordFieldController.dispose();
                          oldPasswordFieldController.dispose();
                          newPasswordFieldController.dispose();
                          Navigator.of(context).pop();
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

  Future<void> _pinDialog(
    SettingsBloc bloc,
    SettingsModel settings, {
    bool isCreate = true,
  }) async {
    final oldPinController = TextEditingController();
    final pinController = TextEditingController();

    return showDialog<void>(
      barrierDismissible: false,
      context: context,
      builder: (BuildContext context) => FutureBuilder(
        future: secureStorage.getPin(),
        builder: (builder, snapshot) => AlertDialog(
          scrollable: false,
          title: Center(
            child: Text(
              isCreate ? 'Setup Pin' : 'Change Pin',
              style: context.titleMedium,
            ),
          ),
          content: Form(
            autovalidateMode: AutovalidateMode.disabled,
            key: _pinForm,
            child: SizedBox(
              width: 350.0,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
                children: [
                  if (!isCreate)
                    Wrap(
                      spacing: 5.0,
                      direction: Axis.vertical,
                      children: [
                        Text('Old Pin', style: context.labelSmall),
                        PinInput(
                          controller: oldPinController,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter your old pin';
                            }

                            if (value != snapshot.data) {
                              oldPinController.clear();
                              return 'Old pin is incorrect';
                            }
                            return null;
                          },
                          onComplete: (value) {},
                        ),
                      ],
                    ),
                  Wrap(
                    spacing: 5.0,
                    direction: Axis.vertical,
                    children: [
                      Text(
                        'New Pin',
                        style: context.labelSmall,
                      ),
                      PinInput(
                        controller: pinController,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter your current password';
                          }
                          return null;
                        },
                        onComplete: (value) {},
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 10.0,
                  ),
                  OverflowBar(
                    spacing: 8.0,
                    children: [
                      ElevatedButton(
                        onPressed: () async {
                          if (_pinForm.currentState!.validate()) {
                            await secureStorage.setPin(pinController.text);
                            await _preferenceService.setPin(true);
                            pinController.clear();
                            oldPinController.clear();
                            bloc.add(const SettingsEvent.updatePinState(true));
                            if (!mounted) return;
                            pinController.dispose();
                            oldPinController.dispose();
                            Navigator.of(context).pop();
                            Alert.showAlert(
                                context, 'App PIN set successfully');
                          }
                        },
                        child: const Text('Submit'),
                      ),
                      ElevatedButton(
                        onPressed: () {
                          pinController.clear();
                          oldPinController.clear();
                          pinController.dispose();
                          oldPinController.dispose();
                          Navigator.of(context).pop();
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

  @override
  void initState() {
    super.initState();
    _availableBiometrics =
        BlocProvider.of<AppBloc>(context).state.availableBiometricsOptions;
  }

  @override
  Widget build(BuildContext context) {
    final settingsBloc = BlocProvider.of<SettingsBloc>(context);
    return BlocBuilder<SettingsBloc, SettingsState>(
      bloc: settingsBloc,
      builder: (builder, settingsState) {
        final settings = SettingsModel.fromStateJson(settingsState.toJson());
        return LayoutBuilder(
          builder: (context, constraints) => SettingsView(
            children: [
              SettingsSection(
                sectionSubHeader: !settings.hasCredentials
                    ? const Padding(
                        padding: EdgeInsets.all(10.0),
                        child: Text(
                          'Your app is not protected. Consider enabling only of the security options below.',
                        ),
                      )
                    : null,
                children:
                    getSecurityOptions(constraints, settingsBloc, settings),
              ),
            ],
          ),
        );
      },
    );
  }
}
