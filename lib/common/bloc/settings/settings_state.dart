part of 'settings_bloc.dart';

@freezed
class SettingsState with _$SettingsState {
  const factory SettingsState({
    required DisplayState display,
    required SecurityState security,
  }) = _SettingsState;

  factory SettingsState.initial() => SettingsState(
      display: DisplayState.initial(), security: SecurityState.initial());

  factory SettingsState.fromJson(Map<String, dynamic> json) =>
      _$SettingsStateFromJson(json);

  factory SettingsState.load(SettingsModel initialData) {
    return SettingsState.initial().copyWith(
      display: DisplayState.load(initialData.display),
      security: SecurityState.load(initialData.security),
    );
  }
}

@freezed
class DisplayState with _$DisplayState {
  const factory DisplayState({
    @Default(true) bool tapToReveal,
    String? primaryColor,
    @Default(false) bool autoBrightness,
  }) = _DisplayState;

  factory DisplayState.initial() => const DisplayState();

  factory DisplayState.fromJson(Map<String, dynamic> json) =>
      _$DisplayStateFromJson(json);

  factory DisplayState.load(Display initialData) {
    return DisplayState.initial().copyWith(
      tapToReveal: initialData.tapToReveal,
      primaryColor: initialData.primaryColor,
      autoBrightness: initialData.autoBrightness,
    );
  }
}

@freezed
class SecurityState with _$SecurityState {
  const factory SecurityState({
    @Default(false) bool hasPassword,
    @Default(false) bool hasPin,
    @Default(false) bool fingerPrint,
  }) = _SecurityState;

  factory SecurityState.initial() => const SecurityState();

  factory SecurityState.fromJson(Map<String, dynamic> json) =>
      _$SecurityStateFromJson(json);

  factory SecurityState.load(Security initialData) {
    return SecurityState.initial().copyWith(
      hasPassword: initialData.hasPassword,
      hasPin: initialData.hasPin,
      fingerPrint: initialData.fingerPrint,
    );
  }
}
