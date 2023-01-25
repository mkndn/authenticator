import 'package:authenticator/common/bloc/settings/settings_bloc.dart';

class SettingsModel {
  Display display;
  Security security;

  SettingsModel({
    Display? displayOptional,
    Security? securityOptional,
  })  : display = displayOptional ?? Display(),
        security = securityOptional ?? Security();

  void copy(SettingsModel other) {
    display.copy(other.display);
    security.copy(other.security);
  }

  bool get hasCredentials => hasFingerPrint() || hasPassword() || hasPin();

  bool hasPassword() => security.hasPassword;

  bool hasPin() => security.hasPin;

  bool hasFingerPrint() => security.fingerPrint;

  factory SettingsModel.fromJson(Map<String, dynamic> json) => SettingsModel(
        displayOptional: Display.fromJson(json),
        securityOptional: Security.fromJson(json),
      );

  factory SettingsModel.fromStateJson(Map<String, dynamic> json) =>
      SettingsModel(
        displayOptional:
            Display.fromJson((json['display'] as DisplayState).toJson()),
        securityOptional:
            Security.fromJson((json['security'] as SecurityState).toJson()),
      );

  Map<String, dynamic> toJson() {
    Map<String, dynamic> result = {};
    result.addAll(display.toJson());
    result.addAll(security.toJson());
    return result;
  }
}

class Display {
  bool tapToReveal;
  String? primaryColor;
  bool autoBrightness;

  Display({
    this.tapToReveal = true,
    this.primaryColor,
    this.autoBrightness = false,
  });

  void copy(Display other) {
    tapToReveal = other.tapToReveal;
    primaryColor = other.primaryColor;
    autoBrightness = other.autoBrightness;
  }

  factory Display.fromJson(Map<String, dynamic> json) => Display(
        tapToReveal: json['tapToReveal'],
        primaryColor: json['primaryColor'],
        autoBrightness: json['autoBrightness'],
      );

  Map<String, dynamic> toJson() => <String, dynamic>{
        'tapToReveal': tapToReveal,
        'primaryColor': primaryColor,
        'autoBrightness': autoBrightness,
      };
}

class Security {
  bool hasPassword;
  bool hasPin;
  bool fingerPrint;

  Security(
      {this.fingerPrint = false,
      this.hasPin = false,
      this.hasPassword = false});

  void copy(Security other) {
    hasPassword = other.hasPassword;
    hasPin = other.hasPin;
    fingerPrint = other.fingerPrint;
  }

  factory Security.fromJson(Map<String, dynamic> json) => Security(
        fingerPrint: json['fingerPrint'],
        hasPassword: json['hasPassword'],
        hasPin: json['hasPin'],
      );

  Map<String, dynamic> toJson() => <String, dynamic>{
        'hasPassword': hasPassword,
        'hasPin': hasPin,
        'fingerPrint': fingerPrint,
      };
}
