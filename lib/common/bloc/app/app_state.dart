part of 'app_bloc.dart';

@freezed
class AppState with _$AppState {
  const factory AppState({
    @Default(false) bool settingsLoaded,
    @Default(false) bool authenticated,
    @Default(false) bool isAuthenticating,
    @Default(false) bool hasCredentials,
    @Default(0) int selectedTabIndexNoMobile,
    @Default([]) List<String> availableBiometricsOptions,
  }) = _AppState;

  factory AppState.initial({
    bool settingsLoadedValue = false,
    bool hasCredentialsValue = false,
    List<String> availableBiometricsList = const [],
  }) =>
      AppState(
        settingsLoaded: settingsLoadedValue,
        hasCredentials: hasCredentialsValue,
        availableBiometricsOptions: availableBiometricsList,
      );

  factory AppState.fromJson(Map<String, dynamic> json) =>
      _$AppStateFromJson(json);
}
