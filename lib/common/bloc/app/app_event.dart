part of 'app_bloc.dart';

@freezed
class AppEvent with _$AppEvent {
  const factory AppEvent.setSettingsLoaded() = SetSettingsLoaded;
  const factory AppEvent.setAuthenticated(bool status) = SetAuthenticated;
  const factory AppEvent.isAuthenticating(bool status) = IsAuthenticating;
  const factory AppEvent.setHasCredentials(bool status) = SetHasCredentials;
  const factory AppEvent.setAvailableBiometricsOptions(List<String> options) =
      SetAvailableBiometricsOptions;
  const factory AppEvent.setSelectedTabIndexNoMobile(int index) =
      SetSelectedTabIndexNoMobile;
}
